import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/reportes/reporte_alta_local.dart';
import '../../data/models/reportes/reporte_danio.dart';
import '../../data/models/reportes/reporte_entrada.dart';
import '../../data/models/reportes/reporte_imagenes.dart';
import '../../data/models/reportes/reporte_salida.dart';
import '../../data/models/system/menu_popup_opciones.dart';
import '../../routes/app_routes.dart';
import '../../utils/color_list.dart';
import '../../utils/get_injection.dart';
import '../../widgets/buttons/circular_buttons.dart';
import '../../widgets/containers/basic_bottom_sheet_container.dart';
import '../../widgets/containers/titulo_container.dart';
import '../../widgets/forms/mover_fila_form.dart';
import '../../widgets/textformfields/danios_textformfield.dart';
import '../../widgets/textformfields/entrada_textformfield.dart';
import '../../widgets/textformfields/salida_textformfield.dart';
import '../../widgets/textforms/multiline_textform.dart';
import '../home/home_controller.dart';

class ReporteController extends GetInjection {
  EntradaTextformfield entradaForm = EntradaTextformfield();
  SalidaTextformfield salidaForm = SalidaTextformfield();
  DaniosTextformfield daniosForm = DaniosTextformfield();
  
  ReporteAltaLocal? reporteAltaLocal;
  String tipoReporte = "";
  DateTime? fechaHoy;
  String fechaReporte = "";
  String fechaReporteAux = "";
  bool editarReporte = false;
  String idTarjaEditar = "";

  ScrollController galeriaScrollController = ScrollController();
  ScrollController formScrollController = ScrollController();
  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  List<List<ReporteImagenes>> reporteImagenes = [];

  bool usarGaleria = false;
  int tipoFila = 0;
  int tabSelected = 0;
  bool mostrarButtonAyudaDanios = false;

  String opcionSelected = "";
  List<MenuPopupOpciones> opcionesConsulta = [];
  List<String> opcionesBase = [
    "Visualizar reporte~B",
    "Solo guardar~B",
    "Guardar y subir~B",
  ];
  List<IconData?> opcionesIcono = [
    FontAwesome5Solid.file_pdf,
    MaterialIcons.save_alt,
    Icons.file_upload_outlined,
  ];

  @override void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    try {
      tipoReporte = Get.arguments['tipo'];
      var inicio = tool.fecha('EEEE, dd');
      var mes = tool.fecha('MMMM');
      var anio = tool.fecha('y');
      fechaReporte = "$inicio de $mes de $anio";
      fechaReporteAux = "$inicio de $mes de $anio";
      if(Get.arguments['formEditar'] == null) {
        if(tipoReporte == "Entrada") {
          entradaForm.horaInicio.text = tool.horaHoy();
          entradaForm.horaFin.text = tool.horaHoy();
          entradaForm.fechaDespacho.text = tool.fechaHoy('dd/MM/yyyy');
          entradaForm.fechaVencimiento.text = tool.fechaHoy('dd/MM/yyyy');
        } else if(tipoReporte == "Salida") {
          salidaForm.horaInicio.text = tool.horaHoy();
          salidaForm.horaFin.text = tool.horaHoy();
        } else if(tipoReporte == "Daños") {
          fechaReporte = tool.fecha('dd/MM/yyyy');
          daniosForm.fechaReporte.text = tool.fechaHoy('dd-MM-yyyy');
          formScrollController.addListener(_scrollListenerDanios);
        }
      } else {
        editarReporte = true;
        if(tipoReporte == "Entrada") {
          entradaForm = Get.arguments['formEditar'] as EntradaTextformfield;
        } else if(tipoReporte == "Salida") {
          salidaForm = Get.arguments['formEditar'] as SalidaTextformfield;
        } else if(tipoReporte == "Daños") {
          fechaReporte = tool.fecha('dd/MM/yyyy');
          daniosForm = Get.arguments['formEditar'] as DaniosTextformfield;
          formScrollController.addListener(_scrollListenerDanios);
        }
        reporteImagenes = Get.arguments['reporteImagenes'] as List<List<ReporteImagenes>>;
        idTarjaEditar = Get.arguments['idTarja'];
      }
      _cargarOpcionesPopup();
    } finally {
      update();
    }
  }

  Future<void> cerrar() async {
    var verify = await ask("Los cambios se perderán", "¿Desea salir?");
    if(!verify) {
      return;
    }
    Get.back();
  }

  void seleccionarTap(int tab) {
    try {
      tabSelected = tab;
      if(tab > 0) {
        mostrarButtonAyudaDanios = false;
      }
      if(tipoReporte == "Entrada") {
        _entradaFormUnfocus();
      } else if(tipoReporte == "Salida") {
        _salidaFormUnfocus();
      } else if(tipoReporte == "Daños") {
        _daniosFormUnfocus();
        _scrollListenerDanios();
      }
    } finally {
      update();
    }
  }

  Future<void> operacionPopUp(String? id) async {
    switch(id) {
      case "0":
        await generarReporte();
        break;
      case "1":
        await soloGuardar();
        break;
      case "2":
        break;
      default:
        return;
    }
  }

  Future<void> generarReporte() async {
    try {
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      dynamic form;
      if(tipoReporte == "Entrada") {
        _entradaFormUnfocus();
        form = entradaForm;
      } else if(tipoReporte == "Salida") {
        _salidaFormUnfocus();
        form = salidaForm;
      } else if(tipoReporte == "Daños") {
        _daniosFormUnfocus();
        form = daniosForm;
      }
      Get.toNamed(
        AppRoutes.reporteView,
        arguments: {
          'tipoReporte' : tipoReporte,
          'fechaReporte' : fechaReporte,
          'formData' : form,
          'reporteImagenes' : reporteImagenes,
          'localStorage' : localStorage,
        },
      );
    } finally {
      update();
    }
  }

  Future<void> soloGuardar() async {
    try {
      isBusy();
      var reportesLocal = await storage.get<List<ReporteAltaLocal>>(ReporteAltaLocal());
      _crearAltaData();
      if(!editarReporte) {
        reportesLocal!.add(reporteAltaLocal!);
      } else {
        for (var i = 0; i < reportesLocal!.length; i++) {
          if(reportesLocal[i].tipo != tipoReporte) {
            continue;
          }
          var idTarjaVerify = "";
          if(tipoReporte == "Entrada") {
            idTarjaVerify = reportesLocal[i].reporteEntrada!.idTarja!;
          } else if(tipoReporte == "Salida") {
            idTarjaVerify = reportesLocal[i].reporteSalida!.idTarja!;
          } else if(tipoReporte == "Daños") {
            idTarjaVerify = reportesLocal[i].reporteDanio!.idTarja!;
          }
          if(idTarjaVerify != idTarjaEditar) {
            continue;
          }
          reportesLocal[i] = reporteAltaLocal!;
        }
      }
      var guardar = await storage.update(reportesLocal);
      if(!guardar) {
        throw Exception();
      }
      await tool.wait(1);
      isBusy(false);
      Get.back();
      await Get.find<HomeController>().recargarReportesLocal();
      msg("Reporte guardado correctamente", MsgType.success);
    } catch(e) {
      msg("Ocurrió un error al intentar guardar el reporte", MsgType.error);
    }
  }
  
  Future<void> tomarFotografia(String idImagen) async {
    try {
      isBusy();
      var fotoCamara = await seleccionarFoto.pickImage(
        source: usarGaleria
          ? ImageSource.gallery
          : ImageSource.camera,
      );
      if (fotoCamara != null) {
        var fotoTemp = File(fotoCamara.path);
        fotografia = await tool.imagenResize(fotoTemp);
        var base64Foto = await tool.imagen2base64(fotografia);
        for (var i = 0; i < reporteImagenes.length; i++) {
          for (var j = 0; j < reporteImagenes[i].length; j++) {
            if(idImagen == reporteImagenes[i][j].idImagen) {
              reporteImagenes[i][j].base64 = base64Foto;
              break;
            }
          }
        }
        update();
      }
    } finally {
      isBusy(false);
    }
  }

  void dateSelected() {
    update();
  }

  void hourSelected() {
    update();
  }

  void onChangedCheck() {
    update();
  }

  void abrirComentario() {
    var context = Get.context;
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: Column(
          children: [
            TituloContainer(
              texto: 'Observaciones',
              size: 16,
            ),
            MultilineTextform(
              icon: Icons.comment,
              lines: 12,
              controller: tipoReporte == "Entrada" 
                ? entradaForm.observaciones 
                : (tipoReporte == "Salida" 
                  ? salidaForm.observaciones 
                  : (tipoReporte == "Daños"
                    ? daniosForm.observaciones
                    : null)),
            ),
          ],
        ),
      ),
    );
  }

  void agregarFilaImagenes() {
    var limite = tipoFila + 2;
    var fila = reporteImagenes.length;
    var posicion = 2;
    List<ReporteImagenes> filaNueva = [
      ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: 0,
      ),
      ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: 1,
      ),
    ];
    for (var i = 2; i < limite; i++) {
      filaNueva.add(ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: posicion,
      ));
      posicion++;
    }
    reporteImagenes.add(filaNueva);
    update();
  }

  Future<void> configurarImagen(String idImagen) async {
    ReporteImagenes? imagen;
    int longitud = 0;
    for (var i = 0; i < reporteImagenes.length; i++) {
      for (var j = 0; j < reporteImagenes[i].length; j++) {
        if(reporteImagenes[i][j].idImagen == idImagen) {
          imagen = reporteImagenes[i][j];
          longitud = reporteImagenes[i].length - 1;
          break;
        }
      }
    }
    if(imagen == null) {
      return;
    }
    var imageBytes = base64Decode(imagen.base64!,);
    var context = Get.context;
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.sys[0],
                    color: ColorList.sys[2],
                    icono: MaterialIcons.chevron_left,
                    onPressed: () => _cambiarPosicionImagen(idImagen, longitud),
                  ),
                ),
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.ui[0],
                    color: ColorList.theme[3],
                    icono: MaterialIcons.delete_outline,
                    onPressed: () => _eliminarImagenLista(imagen),
                  ),
                ),
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.sys[0],
                    color: ColorList.sys[2],
                    icono: MaterialIcons.chevron_right,
                    onPressed: () => _cambiarPosicionImagen(idImagen, longitud, false),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Expanded(
              child: PhotoView(
                imageProvider: MemoryImage(imageBytes),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void configurarFila(int fila) {
    if(reporteImagenes.length == 1) {
      msg("Solo tiene una fila agregada", MsgType.warning);
      return;
    }
    modal(
      widgets: [
        MoverFilaForm(
          filaArriba: () => _cambiarPosicionFila(fila),
          filaAbajo: () => _cambiarPosicionFila(fila, false),
        ),
      ],
    );
  }

  void elimarFilaFotografia(int fila) {
    List<List<ReporteImagenes>> reporteImagenesAux = [];
    for (var i = 0; i < reporteImagenes.length; i++) {
      var numeroFila = reporteImagenes[i][0].fila!;
      if(numeroFila == fila) {
        continue;
      }
      if(numeroFila > fila) {
        var numeroFilaNueva = numeroFila - 1;
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          reporteImagenes[i][j].fila = numeroFilaNueva;
        }
      }
      reporteImagenesAux.add(reporteImagenes[i]);
    }
    reporteImagenes = reporteImagenesAux;
    update();
  }

  void usarGaleriaChanged(bool galeria) {
    usarGaleria = galeria;
    update();
  }

  void tipoFilaChanged(int? fila) {
    tipoFila = fila!;
  }

  void abrirAyudaDanios() {
    
  }

  void _eliminarImagenLista(ReporteImagenes? imagen) {
    try {
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == imagen!.idImagen) {
            reporteImagenes[i][j].base64 = "";
            break;
          }
        }
      }
    tool.closeBottomSheet();
    update();
    } catch(e) {
      msg("Ocurrió un error al intentar eliminar la imagen", MsgType.error);
    }
  }

  void _cambiarPosicionImagen(String? idImagen, int longitud, [bool atras = true]) {
    try {
      ReporteImagenes? imagen;
      String? idImagenRemplazo = "";
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == idImagen) {
            imagen = reporteImagenes[i][j];
            var posicionRemplazo = reporteImagenes[i][j].posicion!;
            var imagenRemplazo = reporteImagenes[i].where(
              (r) => r.posicion == (atras ? posicionRemplazo - 1 : posicionRemplazo + 1)
            ).firstOrNull;
            if(imagenRemplazo != null) {
              idImagenRemplazo = imagenRemplazo.idImagen;
            }
            break;
          }
        }
      }
      if(imagen == null) {
        toast("Error al posicionar imagen");
        return;
      }
      if((atras && imagen.posicion == 0) || (!atras && (imagen.posicion!) == longitud)) {
        toast("Ya se encuentra al ${(atras ? "inicio" : "final")}");
        return;
      }
      var remplazoPrimario = false;
      var remplazoSecundario = false;
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == idImagen) {
            var posicion = reporteImagenes[i][j].posicion!;
            if(atras) {
              reporteImagenes[i][j].posicion = posicion - 1;
            } else {
              reporteImagenes[i][j].posicion = posicion + 1;
            }
            remplazoPrimario = true;
          }
          if(reporteImagenes[i][j].idImagen == idImagenRemplazo) {
            var posicion = reporteImagenes[i][j].posicion!;
            if(atras) {
              reporteImagenes[i][j].posicion = posicion + 1;
            } else {
              reporteImagenes[i][j].posicion = posicion - 1;
            }
            remplazoSecundario = true;
          }
        }
        if(remplazoPrimario && remplazoSecundario) {
          reporteImagenes[i].sort((a, b) => a.posicion!.compareTo(b.posicion!));
        }
      }
      tool.closeBottomSheet();
      update();
    } catch(e) {
      tool.closeBottomSheet();
      msg("Error al configurar la posición de la imagen", MsgType.error);
    } finally {
      update();
    }
  }

  void _cambiarPosicionFila(int fila, [bool arriba = true]) {
    try {
      if((fila == 0 && arriba) || (fila == reporteImagenes.length - 1 && !arriba)) {
        toast("Ya se encuentra al ${(arriba ? "inicio" : "final")}");
        return;
      }
      var filaRemplazo = arriba ? (fila - 1) : (fila + 1);
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].fila == fila) {
            var filaIndex = reporteImagenes[i][j].fila!;
            if(arriba) {
              reporteImagenes[i][j].fila = filaIndex - 1;
            } else {
              reporteImagenes[i][j].fila = filaIndex + 1;
            }
            continue;
          }
          if(reporteImagenes[i][j].fila == filaRemplazo) {
            var filaIndex = reporteImagenes[i][j].fila!;
            if(arriba) {
              reporteImagenes[i][j].fila = filaIndex + 1;
            } else {
              reporteImagenes[i][j].fila = filaIndex - 1;
            }
            continue;
          }
        }
      }
      List<List<ReporteImagenes>> reporteImagenesAux = [];
      var index = 0;
      while(reporteImagenesAux.length < reporteImagenes.length) {
        for (var i = 0; i < reporteImagenes.length; i++) {
          for (var j = 0; j < reporteImagenes[i].length; j++) {
            var reporteImagenAux = reporteImagenes[i];
            if(reporteImagenAux[j].fila! == index) {
              reporteImagenesAux.add(reporteImagenAux);
              break;
            }
          }
        }
        index++;
      }
      modalClose();
      reporteImagenes = reporteImagenesAux;
      update();
    } catch(e) {
      modalClose();
      msg("Ocurrió un error al intentar cambiar la posición de la fila", MsgType.error);
    } finally {
      update();
    }
  }

  void _cargarOpcionesPopup() {
    try {
      opcionesConsulta = [];
      for (var i = 0; i < opcionesBase.length; i++) {
        var opciones = opcionesBase[i].split("~");
        opcionesConsulta.add(MenuPopupOpciones(
          id: i.toString(),
          value: opciones[0],
          tipo: opciones[1],
          icono: opcionesIcono[i],
        ));
      }
      update();
    } finally { }
  }

  void _entradaFormUnfocus() {
    entradaForm.referenciaLmFocus.unfocus();
    entradaForm.imoFocus.unfocus();
    entradaForm.horaInicioFocus.unfocus();
    entradaForm.horaFinFocus.unfocus();
    entradaForm.clienteFocus.unfocus();
    entradaForm.mercanciaFocus.unfocus();
    entradaForm.agenteAduanalFocus.unfocus();
    entradaForm.ejecutivoFocus.unfocus();
    entradaForm.contenedorFocus.unfocus();
    entradaForm.pedimentoFocus.unfocus();
    entradaForm.selloFocus.unfocus();
    entradaForm.buqueFocus.unfocus();
    entradaForm.refClienteFocus.unfocus();
    entradaForm.bultosFocus.unfocus();
    entradaForm.pesoFocus.unfocus();
    entradaForm.terminalFocus.unfocus();
    entradaForm.fechaDespachoFocus.unfocus();
    entradaForm.diasLibresFocus.unfocus();
    entradaForm.fechaDespachoFocus.unfocus();
    entradaForm.movimientoFocus.unfocus();
  }

  void _salidaFormUnfocus() {
    salidaForm.referenciaLmFocus.unfocus();
    salidaForm.imoFocus.unfocus();
    salidaForm.horaInicioFocus.unfocus();
    salidaForm.horaFinFocus.unfocus();
    salidaForm.clienteFocus.unfocus();
    salidaForm.mercanciaFocus.unfocus();
    salidaForm.agenteAduanalFocus.unfocus();
    salidaForm.ejecutivoFocus.unfocus();
    salidaForm.contenedorFocus.unfocus();
    salidaForm.pedimentoFocus.unfocus();
    salidaForm.selloFocus.unfocus();
    salidaForm.buqueFocus.unfocus();
    salidaForm.refClienteFocus.unfocus();
    salidaForm.bultosFocus.unfocus();
    salidaForm.pesoFocus.unfocus();
    salidaForm.terminalFocus.unfocus();
    salidaForm.transporteFocus.unfocus();
    salidaForm.operadorFocus.unfocus();
    salidaForm.placasFocus.unfocus();
    salidaForm.licenciaFocus.unfocus();
  }

  void _daniosFormUnfocus() {
    daniosForm.versionFocus.unfocus();
    daniosForm.claveFocus.unfocus();
    daniosForm.fechaReporteFocus.unfocus();
    daniosForm.lineaNavieraFocus.unfocus();
    daniosForm.clienteFocus.unfocus();
    daniosForm.numContenedorFocus.unfocus();
    daniosForm.numSelloFocus.unfocus();
    daniosForm.intPuertasIzqFocus.unfocus();
    daniosForm.intPuertasDerFocus.unfocus();
    daniosForm.intPisoFocus.unfocus();
    daniosForm.intTechoFocus.unfocus();
    daniosForm.intPanelLateralIzqFocus.unfocus();
    daniosForm.intPanelLateralDerFocus.unfocus();
    daniosForm.intPanelFondoFocus.unfocus();
    daniosForm.extPuertasIzqFocus.unfocus();
    daniosForm.extPuertasDerFocus.unfocus();
    daniosForm.extPosteFocus.unfocus();
    daniosForm.extPalancaFocus.unfocus();
    daniosForm.extGanchoCierreFocus.unfocus();
    daniosForm.extPanelIzqFocus.unfocus();
    daniosForm.extPanelDerFocus.unfocus();
    daniosForm.extPanelFondoFocus.unfocus();
    daniosForm.extCantoneraFocus.unfocus();
    daniosForm.extFrisaFocus.unfocus();
    daniosForm.observacionesFocus.unfocus();
  }

  void _crearAltaData() {
    var idTarja = !editarReporte ? tool.guid() : idTarjaEditar;
    reporteAltaLocal = ReporteAltaLocal(
      tipo: tipoReporte,
    );
    if(tipoReporte == "Entrada") {
      var reporteEntradaAlta = ReporteEntrada(    
        idTarja: idTarja,
        tipo: tipoReporte.toUpperCase(),
        fecha: fechaReporte,
        referenciaLm: entradaForm.referenciaLm.text,
        imo: entradaForm.imo.text,
        horaInicio: entradaForm.horaInicio.text,
        horaFin: entradaForm.horaFin.text,
        cliente: entradaForm.cliente.text,
        mercancia: entradaForm.mercancia.text,
        agenteAduanal: entradaForm.agenteAduanal.text,
        ejecutivo: entradaForm.ejecutivo.text,
        contenedor: entradaForm.contenedor.text,
        pedimento: entradaForm.pedimento.text,
        sello: entradaForm.sello.text,
        buque: entradaForm.buque.text,
        refCliente: entradaForm.refCliente.text,
        bultos: entradaForm.bultos.text,
        peso: entradaForm.peso.text,
        terminal: entradaForm.terminal.text,
        fechaDespacho: entradaForm.fechaDespacho.text,
        diasLibres: entradaForm.diasLibres.text,
        fechaVencimiento: entradaForm.fechaVencimiento.text,
        movimiento: entradaForm.movimiento.text,
        observaciones: entradaForm.observaciones.text,
        imagenes: _generarListaImagenesAlta(idTarja),
      );
      reporteAltaLocal!.reporteEntrada = reporteEntradaAlta;
    } else if(tipoReporte == "Salida") {
      var reporteSalidaAlta = ReporteSalida(    
        idTarja: idTarja,
        tipo: tipoReporte.toUpperCase(),
        fecha: fechaReporte,
        referenciaLm: salidaForm.referenciaLm.text,
        imo: salidaForm.imo.text,
        horaInicio: salidaForm.horaInicio.text,
        horaFin: salidaForm.horaFin.text,
        cliente: salidaForm.cliente.text,
        mercancia: salidaForm.mercancia.text,
        agenteAduanal: salidaForm.agenteAduanal.text,
        ejecutivo: salidaForm.ejecutivo.text,
        contenedor: salidaForm.contenedor.text,
        pedimento: salidaForm.pedimento.text,
        sello: salidaForm.sello.text,
        buque: salidaForm.buque.text,
        refCliente: salidaForm.refCliente.text,
        bultos: salidaForm.bultos.text,
        peso: salidaForm.peso.text,
        terminal: salidaForm.terminal.text,
        transporte: salidaForm.transporte.text,
        operador: salidaForm.operador.text,
        placas: salidaForm.placas.text,
        licencia: salidaForm.licencia.text,
        observaciones: salidaForm.observaciones.text,
        imagenes: _generarListaImagenesAlta(idTarja),
      );
      reporteAltaLocal!.reporteSalida = reporteSalidaAlta;
    } else if(tipoReporte == "Daños") {
      var reporteDanioAlta = ReporteDanio(
        idTarja: idTarja,
        tipo: tipoReporte.toUpperCase(),
        fecha: fechaReporte,
        fechaCreado: fechaReporteAux,
        version: daniosForm.version.text,
        clave: daniosForm.clave.text,
        fechaReporte: daniosForm.fechaReporte.text,
        lineaNaviera: daniosForm.lineaNaviera.text,
        cliente: daniosForm.cliente.text,
        numContenedor: daniosForm.numContenedor.text,
        vacio: daniosForm.vacio ? "X" : "",
        lleno: daniosForm.lleno ? "X" : "",
        d20: daniosForm.d20 ? "X" : "",
        d40: daniosForm.d40 ? "X" : "",
        hc: daniosForm.hc ? "X" : "",
        otro: daniosForm.otro ? "X" : "",
        estandar: daniosForm.estandar ? "X" : "",
        opentop: daniosForm.opentop ? "X" : "",
        flatRack: daniosForm.flatRack ? "X" : "",
        reefer: daniosForm.reefer ? "X" : "",
        reforzado: daniosForm.reforzado ? "X" : "",
        numSello: daniosForm.numSello.text,
        intPuertasIzq: daniosForm.intPuertasIzq.text,
        intPuertasDer: daniosForm.intPuertasDer.text,
        intPiso: daniosForm.intPiso.text,
        intTecho: daniosForm.intTecho.text,
        intPanelLateralIzq: daniosForm.intPanelLateralIzq.text,
        intPanelLateralDer: daniosForm.intPanelLateralDer.text,
        intPanelFondo: daniosForm.intPanelFondo.text,
        extPuertasIzq: daniosForm.extPuertasIzq.text,
        extPuertasDer: daniosForm.extPuertasDer.text,
        extPoste: daniosForm.extPoste.text,
        extPalanca: daniosForm.extPalanca.text,
        extGanchoCierre: daniosForm.extGanchoCierre.text,
        extPanelIzq: daniosForm.extPanelIzq.text,
        extPanelDer: daniosForm.extPanelDer.text,
        extPanelFondo: daniosForm.extPanelFondo.text,
        extCantonera: daniosForm.extCantonera.text,
        extFrisa: daniosForm.extFrisa.text,
        observaciones: daniosForm.observaciones.text,
        imagenes: _generarListaImagenesAlta(idTarja),
      );
      reporteAltaLocal!.reporteDanio = reporteDanioAlta;
    }
  }

  void _scrollListenerDanios() {
    try {
      if(tabSelected > 0) {
        mostrarButtonAyudaDanios = false;
        update();
        return;
      }
      if(formScrollController.offset > 170 && !mostrarButtonAyudaDanios) {
        mostrarButtonAyudaDanios = true;
        update();
      } else if(formScrollController.offset <= 170 && mostrarButtonAyudaDanios) {
        mostrarButtonAyudaDanios = false;
        update();
      }
    } finally { }
  }

  List<ReporteImagenes> _generarListaImagenesAlta(String idTarja) {
    List<ReporteImagenes> listaAlta = [];
    for (var i = 0; i < reporteImagenes.length; i++) {
      for (var j = 0; j < reporteImagenes[i].length; j++) {
        var imagenReporte = reporteImagenes[i][j];
        imagenReporte.idTarja = idTarja;
        imagenReporte.formato = "jpg";
        listaAlta.add(reporteImagenes[i][j]);
      }
    }
    return listaAlta;
  }
}
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/reportes/reporte_alta_local.dart';
import '../../data/models/reportes/reporte_imagenes.dart';
import '../../data/models/system/menu_opciones.dart';
import '../../routes/app_routes.dart';
import '../../utils/get_injection.dart';
import '../../widgets/textformfields/entrada_textformfield.dart';
import '../../widgets/textformfields/salida_textformfield.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class HomeController extends GetInjection {
  EntradaTextformfield entradaForm = EntradaTextformfield();
  SalidaTextformfield salidaForm = SalidaTextformfield();
  
  TextEditingController fechaBusqueda = TextEditingController();
  FocusNode fechaBusquedaFocus = FocusNode();

  List<ReporteAltaLocal>? reportesLocal = [];
  List<MenuOpciones> menuOpciones = [];
  bool cargandoReportes = true;

  String nombreMenu = "";
  String usuarioMenu = "";

  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  bool isAdmin = GetInjection.administrador;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    try {
      fechaBusqueda.text = tool.fecha('dd/MM/yyyy');
      menuOpciones = [
        MenuOpciones(
          titulo: "Entradas",
          icono: MaterialCommunityIcons.truck_delivery_outline,
          accion: () => _abrirVista(AppRoutes.reporte, { "tipo" : "Entrada" }),
        ),
        MenuOpciones(
          titulo: "Salidas",
          icono: MaterialCommunityIcons.truck_flatbed,
          accion: () => _abrirVista(AppRoutes.reporte, { "tipo" : "Salida" }),
        ),
        MenuOpciones(
          titulo: "Registro de daños",
          icono: MaterialCommunityIcons.truck_remove_outline,
          accion: () => _abrirVista(AppRoutes.reporte, { "tipo" : "Daños" }),
        ),
      ];
      if(isAdmin) {
        menuOpciones.add(MenuOpciones(
          titulo: "Usuarios",
          icono: MaterialCommunityIcons.account_cog_outline,
          accion: () => _abrirVista(AppRoutes.usuarios),
        ));
      }
      var arguments = Get.arguments;
      nombreMenu = arguments['nombre'] ?? "";
      usuarioMenu = arguments['usuario'] ?? "";
      await recargarReportesLocal();
    } finally {
      update();
    }
  }

  Future<void> cambiarOpcionMenu(int? index) async {
    if(index == 0) {

    } else if(index == 1) {
      await recargarReportesLocal();
    }
  }

  Future<void> abrirReporte(ReporteAltaLocal reporte) async {
    tool.debug(reporte, true);
    dynamic form;
    String fechaReporte = "";
    List<ReporteImagenes> listaImagenes = [];
    _fillFormsReportes(reporte);
    if(reporte.tipo == "Entrada") {
      form = entradaForm;
      fechaReporte = reporte.reporteEntrada!.fecha!;
      listaImagenes = reporte.reporteEntrada!.imagenes!;
    } else if(reporte.tipo! == "Salida") {
      form = salidaForm;
      fechaReporte = reporte.reporteSalida!.fecha!;
      listaImagenes = reporte.reporteSalida!.imagenes!;
    }
    List<List<ReporteImagenes>> reporteImagenes = crearListaImagenes(listaImagenes);
    Get.toNamed(
      AppRoutes.reporteView,
      arguments: {
        'tipoReporte' : reporte.tipo,
        'fechaReporte' : fechaReporte,
        'formData' : form,
        'reporteImagenes' : reporteImagenes,
      },
    );
  }

  List<List<ReporteImagenes>> crearListaImagenes(List<ReporteImagenes> reporteImagenes) {
    List<List<ReporteImagenes>> listaImagenes = [];
    reporteImagenes.sort((a, b) {
      var comp = a.fila!.compareTo(b.fila!);
      if(comp != 0) {
        return comp;
      }
      return a.posicion!.compareTo(b.posicion!);
    });
    List<int> filas = [];
    for (var i = 0; i < reporteImagenes.length; i++) {
      if(!filas.contains(reporteImagenes[i].fila)) {
        filas.add(reporteImagenes[i].fila!);
      }
    }
    var contFila = 0;
    for (var i = 0; i < filas.length; i++) {
      contFila = contFila + filas[i];
    }
    List<ReporteImagenes> imagenesReporte = [];
    for (var i = 0; i <= contFila; i++) {
      for (var j = 0; j < reporteImagenes.length; j++) {
        if(reporteImagenes[j].fila != i) {
          continue;
        }
        imagenesReporte.add(reporteImagenes[j]);
      }
      listaImagenes.add(imagenesReporte);
      imagenesReporte = [];
    }
    return listaImagenes;
  }

  Future<void> recargarReportesLocal() async {
    try {
      reportesLocal = await storage.get<List<ReporteAltaLocal>>(ReporteAltaLocal());
    } catch(e) {
      msg("Ocurrió un error al cargar listado de reportes pendientes", MsgType.error);
    } finally {
      update();
    }
  }

  Future<void> cerrarSesion() async {
    try {
      var verify = await ask("Cerrar sesión", "¿Desea continuar?");
      if(!verify) {
        return;
      }
      isBusy();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      localStorage!.login = false;
      await storage.update(localStorage);
      isBusy(false);
      Get.offAll(
        const LoginPage(),
        binding: LoginBinding(),
        transition: Transition.leftToRight,
        duration: 1.5.seconds,
      );
    } catch(e) {
      msg("Ocurrió un error al cerrar sesión", MsgType.error);
    }
  }

  void dateSelected() {
    update();
  }

  void _fillFormsReportes(ReporteAltaLocal reporte) {
    if(reporte.tipo! == "Entrada") {
      entradaForm.referenciaLm.text = reporte.reporteEntrada!.referenciaLm!;
      entradaForm.imo.text = reporte.reporteEntrada!.imo!;
      entradaForm.horaInicio.text = reporte.reporteEntrada!.horaInicio!;
      entradaForm.horaFin.text = reporte.reporteEntrada!.horaFin!;
      entradaForm.cliente.text = reporte.reporteEntrada!.cliente!;
      entradaForm.mercancia.text = reporte.reporteEntrada!.mercancia!;
      entradaForm.agenteAduanal.text = reporte.reporteEntrada!.agenteAduanal!;
      entradaForm.ejecutivo.text = reporte.reporteEntrada!.ejecutivo!;
      entradaForm.contenedor.text = reporte.reporteEntrada!.contenedor!;
      entradaForm.pedimento.text = reporte.reporteEntrada!.pedimento!;
      entradaForm.sello.text = reporte.reporteEntrada!.sello!;
      entradaForm.buque.text = reporte.reporteEntrada!.buque!;
      entradaForm.refCliente.text = reporte.reporteEntrada!.refCliente!;
      entradaForm.bultos.text = reporte.reporteEntrada!.bultos!;
      entradaForm.peso.text = reporte.reporteEntrada!.peso!;
      entradaForm.terminal.text = reporte.reporteEntrada!.terminal!;
      entradaForm.fechaDespacho.text = reporte.reporteEntrada!.fechaDespacho!;
      entradaForm.diasLibres.text = reporte.reporteEntrada!.diasLibres!;
      entradaForm.fechaVencimiento.text = reporte.reporteEntrada!.fechaVencimiento!;
      entradaForm.movimiento.text = reporte.reporteEntrada!.movimiento!;
      entradaForm.observaciones.text = reporte.reporteEntrada!.observaciones!;
    } else if(reporte.tipo! == "Salida") {
      salidaForm.referenciaLm.text = reporte.reporteSalida!.referenciaLm!;
      salidaForm.imo.text = reporte.reporteSalida!.imo!;
      salidaForm.horaInicio.text = reporte.reporteSalida!.horaInicio!;
      salidaForm.horaFin.text = reporte.reporteSalida!.horaFin!;
      salidaForm.cliente.text = reporte.reporteSalida!.cliente!;
      salidaForm.mercancia.text = reporte.reporteSalida!.mercancia!;
      salidaForm.agenteAduanal.text = reporte.reporteSalida!.agenteAduanal!;
      salidaForm.ejecutivo.text = reporte.reporteSalida!.ejecutivo!;
      salidaForm.contenedor.text = reporte.reporteSalida!.contenedor!;
      salidaForm.pedimento.text = reporte.reporteSalida!.pedimento!;
      salidaForm.sello.text = reporte.reporteSalida!.sello!;
      salidaForm.buque.text = reporte.reporteSalida!.buque!;
      salidaForm.refCliente.text = reporte.reporteSalida!.refCliente!;
      salidaForm.bultos.text = reporte.reporteSalida!.bultos!;
      salidaForm.peso.text = reporte.reporteSalida!.peso!;
      salidaForm.terminal.text = reporte.reporteSalida!.terminal!;
      salidaForm.transporte.text = reporte.reporteSalida!.transporte!;
      salidaForm.operador.text = reporte.reporteSalida!.operador!;
      salidaForm.placas.text = reporte.reporteSalida!.placas!;
      salidaForm.licencia.text = reporte.reporteSalida!.licencia!;
      salidaForm.observaciones.text = reporte.reporteSalida!.observaciones!;
    }
  }

  void _abrirVista(String ruta, [dynamic arguments]) {
    Get.toNamed(
      ruta,
      arguments: arguments,
    );
  }
}
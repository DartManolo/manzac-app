import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/login/login_form.dart';
import '../../data/models/reportes/reporte_alta_local.dart';
import '../../data/models/reportes/reporte_imagenes.dart';
import '../../data/models/system/menu_opciones.dart';
import '../../data/models/system/menu_popup_opciones.dart';
import '../../data/models/system/usuarios_busqueda.dart';
import '../../data/models/usuarios/notificacion_forbiden.dart';
import '../../routes/app_routes.dart';
import '../../utils/color_list.dart';
import '../../utils/get_injection.dart';
import '../../utils/literals.dart';
import '../../widgets/columns/password_column.dart';
import '../../widgets/containers/basic_bottom_sheet_container.dart';
import '../../widgets/textformfields/danios_textformfield.dart';
import '../../widgets/textformfields/entrada_textformfield.dart';
import '../../widgets/textformfields/salida_textformfield.dart';
import '../../widgets/texts/combo_texts.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class HomeController extends GetInjection {
  PageController? menuController;
  int menuIndex = 0;
  ScrollController pendientesScrollController = ScrollController();
  ScrollController servidorScrollController = ScrollController();
  ScrollController ajustesScrollController = ScrollController();
  EntradaTextformfield entradaForm = EntradaTextformfield();
  SalidaTextformfield salidaForm = SalidaTextformfield();
  DaniosTextformfield daniosForm = DaniosTextformfield();
  
  TextEditingController fechaBusqueda = TextEditingController();
  FocusNode fechaBusquedaFocus = FocusNode();

  TextEditingController nuevaPassword = TextEditingController();
  FocusNode nuevaPasswordFocus = FocusNode();
  TextEditingController repetirPassword = TextEditingController();
  FocusNode repetirPasswordFocus = FocusNode();

  String opcionSelected = "";
  List<MenuPopupOpciones> opcionesConsulta = [];
  List<String> opcionesBase = [
    "Consulta avanzada~B",
  ];
  List<IconData?> opcionesIcono = [
    FontAwesome5Solid.search,
  ];

  List<String> tiposReporte = [
    "Todos",
    "Entrada",
    "Salida",
    "Daños"
  ];
  TextEditingController tipoReporteBusqueda = TextEditingController();
  List<BottomSheetAction> listaTiposReportes = [];
  String tipoReporteSelected = "";

  List<UsuariosBusqueda> usuariosReporte = [];
  TextEditingController usuariosBusqueda = TextEditingController();
  List<BottomSheetAction> listaUsuarios = [];
  String usuarioSelected = "";

  List<ReporteAltaLocal>? reportesServidor = [];
  List<ReporteAltaLocal>? reportesServidorAux = [];
  bool cargandoReportes = true;
  bool conInternet = true;

  List<ReporteAltaLocal>? reportesLocal = [];
  double reportesLocalSize = 0;
  double reportesLocalSizeLimit = 25;
  bool mostrarAlertaPendientes = true;
  List<MenuOpciones> menuOpciones = [];
  bool mayusculas = false;

  String idUsuarioMenu = "";
  String nombreMenu = "";
  String usuarioMenu = "";
  String perfilMenu = "";

  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  bool isAdmin = GetInjection.administrador;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await _ready();
    super.onReady();
  }

  @override
  void dispose() {
    menuController?.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      menuController = PageController();
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
          icono: Octicons.container,
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
      _cargarOpcionesPopup();
      tipoReporteSelected = tiposReporte.first;
      tipoReporteBusqueda.text = tiposReporte.first;
      _cargarTipoReporteBusquedaLista();
      _crearFiltroUsuarios();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      mayusculas = localStorage!.mayusculas!;
      idUsuarioMenu = localStorage.idUsuario!;
      nombreMenu = localStorage.nombre!;
      usuarioMenu = localStorage.usuario!;
      perfilMenu = localStorage.perfil!;
      await recargarReportesLocal();
    } finally {
      update();
    }
  }

  Future<void> _ready() async {
    await _validarEstatusUsuario();
    await _obtenerReportesServidor();
    if(mostrarAlertaPendientes && reportesLocal!.isNotEmpty) {
      mostrarAlertaPendientes = false;
      await tool.wait(1);
      msg("Le recordamos que tiene reportes pendientes por subir al servidor", MsgType.warning);
    }
  }

  Future<void> operacionPopUp(String? id) async {
    switch(id) {
      case "0":
        _consultaAvanzadaReportesServidor();
        break;
      default:
        return;
    }
  }

  Future<void> menuPageChanged(int index) async {
    menuIndex = index;
    update();
    if(index == 0) {

    } else if(index == 1) {
      await recargarReportesLocal();
    }
  }

  void menuItemSelected(int index) {
    menuIndex = index;
    menuController?.jumpToPage(index);
    update(); 
  }

  Future<void> abrirReporteServidor(ReporteAltaLocal reporte, String idTarja) async {
    try {
      isBusy();
      var verifyOnline = await tool.isOnline();
      if(!verifyOnline) {
        await tool.wait(1);
        msg("Al parecer no cuenta con conexión a internet. Verifíquela y vuelva a intentarlo", MsgType.warning);
        return;
      }
      var imagenes = await reportesRepository.consultaImagenesReporteAsync(idTarja);
      if(imagenes == null) {
        throw Exception();
      }
      await tool.wait(1);
      if(reporte.tipo == "Entrada") {
        reporte.reporteEntrada!.imagenes = imagenes;
      } else if(reporte.tipo! == "Salida") {
        reporte.reporteSalida!.imagenes = imagenes;
      } else if(reporte.tipo! == "Daños") {
        reporte.reporteDanio!.imagenes = imagenes;
      }
      isBusy(false);
      await gestionarReporteLocal(reporte);
    } catch(e) {
      msg("Ocurrió un error al visualizar reporte", MsgType.error);
    }
  }

  Future<void> gestionarReporteLocal(ReporteAltaLocal reporte, [bool visualizar = true]) async {
    dynamic form;
    String fechaReporte = "";
    String idTarja = "";
    List<ReporteImagenes> listaImagenes = [];
    _fillFormsReportes(reporte);
    if(reporte.tipo == "Entrada") {
      form = entradaForm;
      fechaReporte = reporte.reporteEntrada!.fecha!;
      idTarja = reporte.reporteEntrada!.idTarja!;
      listaImagenes = reporte.reporteEntrada!.imagenes!;
    } else if(reporte.tipo! == "Salida") {
      form = salidaForm;
      fechaReporte = reporte.reporteSalida!.fecha!;
      idTarja = reporte.reporteSalida!.idTarja!;
      listaImagenes = reporte.reporteSalida!.imagenes!;
    } else if(reporte.tipo! == "Daños") {
      form = daniosForm;
      fechaReporte = reporte.reporteDanio!.fecha!;
      idTarja = reporte.reporteDanio!.idTarja!;
      listaImagenes = reporte.reporteDanio!.imagenes!;
    }
    List<List<ReporteImagenes>> reporteImagenes = crearListaImagenes(listaImagenes);
    if(visualizar) {
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      Get.toNamed(
        AppRoutes.reporteView,
        arguments: {
          'tipoReporte' : reporte.tipo,
          'fechaReporte' : fechaReporte,
          'formData' : form,
          'reporteImagenes' : reporteImagenes,
          'localStorage' : localStorage,
        },
      );
    } else {
      Get.toNamed(
        AppRoutes.reporte,
        arguments: {
          "tipo" : reporte.tipo,
          "formEditar": form,
          "reporteImagenes": reporteImagenes,
          "idTarja": idTarja,
        },
      );
    }
  }

  Future<void> subirReportePendiente(ReporteAltaLocal reporte) => _subirPendiente([reporte]);

  Future<void> subirTodosReportesPendientes() => _subirPendiente(reportesLocal!, true);

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
      var listaString = jsonEncode(reportesLocal);
      var listaBytes = Uint8List.fromList(utf8.encode(listaString)).lengthInBytes;
      reportesLocalSize = listaBytes / (1024 * 1024);
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
        duration: 1.seconds,
      );
    } catch(e) {
      msg("Ocurrió un error al cerrar sesión", MsgType.error);
    }
  }

  Future<void> reestablcerAplicacion() async {
    try {
      if(reportesLocal!.isNotEmpty) {
        /*var verifyRepo = await ask("¡Tiene reportes pendientes!", "Si Acepta, TODOS los pendientes se perderán, ¿Desea continuar?");
        if(!verifyRepo) {
          return;
        }*/
        msg("¡Tiene reportes pendientes!, es necesario subir los reportes pendientes al servidor", MsgType.warning);
        try {
          var notificacion = NotificacionForbiden(
            titulo: "Atención!",
            cuerpo: "El usuario $usuarioMenu intentó salir de la sesión con ${reportesLocal!.length} reporte(s) pendiente(s)",
            idSistema: idUsuarioMenu,
          );
          var _ = await usuariosRepository.notificarAdminsForbidenLogoutAsync(notificacion);
        } finally { }
        return;
      }
      var verify = await ask("Salir de la sesión", "¿Desea continuar?");
      if(!verify) {
        return;
      }
      isBusy();
      var _ = await storage.update(LocalStorage());
      var _ = await storage.delete(ReporteAltaLocal());
      var _ = await storage.put([ReporteAltaLocal()]);
      await tool.wait();
      isBusy(false);
      Get.offAll(
        const LoginPage(),
        binding: LoginBinding(),
        transition: Transition.leftToRight,
        duration: 1.5.seconds,
      );
    } catch(e) {
      msg("Ocurrió un error al intentar reestablecer su sesión", MsgType.error);
    }
  }

  Future<void> obtenerFirmas() async {
    try {
      isBusy();
      var configuracionFirmas = await configuracionRepository.obtenerConfiguracionAsync("firmas");
      if(configuracionFirmas == null) {
        throw Exception();
      }
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      localStorage!.firmaOperaciones = configuracionFirmas.firmaOperador;
      localStorage.firmaGerencia = configuracionFirmas.firmaGerencia;
      await storage.update(localStorage);
      msg("Firmas actualizadas correctamente", MsgType.success);
    } catch(e) {
      msg("Ocurrió un error al intentar obtener las firmas del servidor", MsgType.error);
    } finally {
      update();
    }
  }

  void cambiarPasswordForm() {
    var context = Get.context;
    nuevaPassword.text = "";
    repetirPassword.text = "";
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: PasswordColumn(
          nuevaPassword: nuevaPassword,
          nuevaPasswordFocus: nuevaPasswordFocus,
          repetirPassword: repetirPassword,
          repetirPasswordFocus: repetirPasswordFocus,
          esNueva: false,
          guardarPassword: _actualizarPassword,
        ),
      ),
    );
  }

  Future<void> configMayusculas(bool mayus) async {
    try {
      isBusy();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      localStorage!.mayusculas = mayus;
      var actualizar = await storage.update(localStorage);
      if(!actualizar) {
        throw Exception();
      }
      mayusculas = mayus;
      isBusy(false);
    } catch(e) {
      msg("Ocurrió un error al guardar la configuración", MsgType.error);
    } finally {
      update();
    }
  }

  Future<void> verFirma(String firma) async {
    try {
      isBusy();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      var firmaLocal = "";
      if(firma == "OPERACIONES") {
        firmaLocal = localStorage!.firmaOperaciones!;
      } else if(firma == "GERENCIA") {
        firmaLocal = localStorage!.firmaGerencia!;
      }
      if(firmaLocal == "") {
        msg("No tiene una firma (${firma.toLowerCase()}) en la configuración");
        return;
      }
      isBusy(false);
      var imageBytes = base64Decode(firmaLocal);
      var context = Get.context;
      showMaterialModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context!,
        expand: true,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => BasicBottomSheetContainer(
          context: context,
          cerrar: true,
          child: Column(
            children: [
              Text(
                "Firma ${firma.toLowerCase()}",
                style: TextStyle(
                  color: Color(ColorList.sys[0]),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: PhotoView(
                  imageProvider: MemoryImage(imageBytes),
                ),
              ),
            ],
          ),
        ),
      );
    } catch(e) {
      msg("Ocurrió un error al visualizar la firma", MsgType.error);
    }
  }

  Future<void> configFirma(String firma) async {
    try {
      var fotoFirma = await seleccionarFoto.pickImage(
        source: ImageSource.gallery,
      );
      if (fotoFirma != null) {
        var verify = await ask("Guardar firma", "La firma se enviará al servidor, ¿Desea continuar?");
        if(!verify) {
          return;
        }
        isBusy();
        var fotoTemp = File(fotoFirma.path);
        fotografia = await tool.imagenResize(fotoTemp, maxWidth: 160);
        var base64Foto = await tool.imagen2base64(fotografia);
        var localStorage = await storage.get<LocalStorage>(LocalStorage());
        var firmaServer = "";
        if(firma == "OPERACIONES") {
          localStorage!.firmaOperaciones = base64Foto;
          firmaServer = "firma_operador.txt";
        } else if(firma == "GERENCIA") {
          localStorage!.firmaGerencia = base64Foto;
          firmaServer = "firma_gerencia.txt";
        }
        var actualizarServer = await configuracionRepository.guardarFirmaAsync("${Literals.rutaFirmasApi}$firmaServer", base64Foto);
        if(!actualizarServer) {
          throw Exception();
        }
        var actualizar = await storage.update(localStorage);
        if(!actualizar) {
          throw Exception();
        }
        msg("La firma de ${firma.toLowerCase()} se guardó correctamente", MsgType.success);
      }
    } catch(e) {
      msg("Ocurrió un error al guardar la configuración de la firma", MsgType.error);
    }
  }

  Future<void> _obtenerReportesServidor() async {
    try {
      reportesServidor = [];
      reportesServidorAux = [];
      if(!cargandoReportes) {
        cargandoReportes = true;
        update();
      }
      conInternet = await tool.isOnline();
      if(!conInternet) {
        await tool.wait(1);
        return;
      }
      var fechaArr = fechaBusqueda.text.split("/");
      var fechaConsulta = "${fechaArr[2]}-${fechaArr[1]}-${fechaArr[0]}";
      var result = await reportesRepository.consultaReporteAsync(fechaConsulta);
      reportesServidor = result;
      reportesServidorAux = result;
    } catch(e) {
      return;
    } finally {
      cargandoReportes = false;
      _crearFiltroUsuarios();
      _filtarReportesServidor();
      update();
    }
  }

  void _filtarReportesServidor([bool recargar = false]) {
    if(reportesServidorAux!.isEmpty) {
      return;
    }
    var reportesServidorQuery = reportesServidorAux;
    if(tipoReporteBusqueda.text != tiposReporte[0]) {
      reportesServidorQuery = reportesServidorQuery!.where((r) => r.tipo == tipoReporteBusqueda.text).toList();
    }
    if(!isAdmin) {
      reportesServidorQuery = reportesServidorQuery!.where((reporte) {
        if(reporte.tipo == "Entrada") {
          return reporte.reporteEntrada!.usuario == idUsuarioMenu;
        } else if(reporte.tipo! == "Salida") {
          return reporte.reporteSalida!.usuario == idUsuarioMenu;
        } else if(reporte.tipo! == "Daños") {
          return reporte.reporteDanio!.usuario == idUsuarioMenu;
        } else {
          return false;
        }
      }).toList();
    }
    if(usuarioSelected != "TODOS") {
      reportesServidorQuery = reportesServidorQuery!.where((reporte) {
        if(reporte.tipo == "Entrada") {
          return reporte.reporteEntrada!.usuario == usuarioSelected;
        } else if(reporte.tipo! == "Salida") {
          return reporte.reporteSalida!.usuario == usuarioSelected;
        } else if(reporte.tipo! == "Daños") {
          return reporte.reporteDanio!.usuario == usuarioSelected;
        } else {
          return false;
        }
      }).toList();
    }
    reportesServidor = reportesServidorQuery;
    if(recargar) {
      update();
    }
  }

  void _crearFiltroUsuarios([bool inicio = true]) {
    try {
      listaUsuarios = [];
      usuariosReporte = [
        UsuariosBusqueda(
          id: "TODOS",
          nonbre: "Todos los usuarios",
        ),
      ];
      if(inicio) {
        usuarioSelected = usuariosReporte.first.id!;
        usuariosBusqueda.text = usuariosReporte.first.nonbre!;
      }
      for (var i = 0; i < reportesServidorAux!.length; i++) {
        var nombre = "";
        var usuario = "";
        if(reportesServidorAux![i].tipo == "Entrada") {
          nombre = reportesServidorAux![i].reporteEntrada!.nombreUsuario!;
          usuario = reportesServidorAux![i].reporteEntrada!.usuario!;
        } else if(reportesServidorAux![i].tipo == "Salida") {
          nombre = reportesServidorAux![i].reporteSalida!.nombreUsuario!;
          usuario = reportesServidorAux![i].reporteSalida!.usuario!;
        } else if(reportesServidorAux![i].tipo == "Daños") {
          nombre = reportesServidorAux![i].reporteDanio!.nombreUsuario!;
          usuario = reportesServidorAux![i].reporteDanio!.usuario!;
        }
        var verify = usuariosReporte.where((u) => u.id == usuario).firstOrNull;
        if(verify == null) {
          usuariosReporte.add(UsuariosBusqueda(
            id: usuario,
            nonbre: nombre
          ));
        }
      }
      for (var i = 0; i < usuariosReporte.length; i++) {
        listaUsuarios.add(
          BottomSheetAction(
            title: ComboText(
              texto: usuariosReporte[i].nonbre!,
              fontWeight: usuarioSelected == usuariosReporte[i].id
                ? FontWeight.bold
                : FontWeight.normal,
            ),
            onPressed: (context) {
              usuariosBusqueda.text = usuariosReporte[i].nonbre!;
              usuarioSelected = usuariosReporte[i].id!;
              update();
              Navigator.of(context).pop();
              _filtrarUsuarioBusquedaOnline();
            },
          ),
        );
      }
    } finally { }
  }

  void _consultaAvanzadaReportesServidor() { }

  Future<void> _subirPendiente(List<ReporteAltaLocal> reportes, [bool multiple = false]) async {
    try {
      var verify = await ask("Subir ${(multiple ? "todos los reportes" : "reporte")}", "¿Desea continuar?");
      if(!verify) {
        return;
      }
      isBusy();
      var subirReporte = await reportesRepository.altaReporteAsync(reportes);
      if(!subirReporte) {
        throw Exception();
      }
      var actualiza = false;
      if(multiple) {
        reportesLocal = [];
        var _ = await storage.delete(ReporteAltaLocal());
        actualiza = await storage.put([ReporteAltaLocal()]);
      } else {
        var reporte = reportes.first;
        List<ReporteAltaLocal> reportesLocalAux = [];
        for (var i = 0; i < reportesLocal!.length; i++) {
          if(reportesLocal![i].tipo != reporte.tipo) {
            reportesLocalAux.add(reportesLocal![i]);
            continue;
          }
          var idTarja = "";
          var idTarjaAlta = "";
          if(reporte.tipo == "Entrada") {
            idTarja = reportesLocal![i].reporteEntrada!.idTarja!;
            idTarjaAlta = reporte.reporteEntrada!.idTarja!;
          } else if(reporte.tipo == "Salida") {
            idTarja = reportesLocal![i].reporteSalida!.idTarja!;
            idTarjaAlta = reporte.reporteSalida!.idTarja!;
          } else if(reporte.tipo == "Daños") {
            idTarja = reportesLocal![i].reporteDanio!.idTarja!;
            idTarjaAlta = reporte.reporteDanio!.idTarja!;
          }
          if(idTarja != idTarjaAlta) {
            reportesLocalAux.add(reportesLocal![i]);
          }
        }
        reportesLocal = reportesLocalAux;
        if(reportesLocal!.isNotEmpty) {
          actualiza = await storage.update(reportesLocal);
        } else {
          var _ = await storage.delete(ReporteAltaLocal());
          actualiza = await storage.put([ReporteAltaLocal()]);
        }
      }
      update();
      if(!actualiza) {
        msg(
          "${(multiple ? "Los reportes se subieron al servidor" : "El reporte se subió al servidor")}, pero ocurrió un problema al actualizar la lista de pendientes.", 
          MsgType.warning
        );
        return;
      }
      msg(
        multiple ? "Los reportes han sido enviados al servidor" : "El reporte ha sido enviado al servidor", 
        MsgType.success
      );
    } catch(e) {
      msg("Ocurrió un error al intentar subir ${(multiple ? "reportes pendientes" : "reporte pendiente")}", MsgType.error);
    }
  }

  void _filtrarTipoReporteBusquedaOnline() {
    try {
      _cargarTipoReporteBusquedaLista();
      _filtarReportesServidor(true);
    } finally { }
  }

  void _filtrarUsuarioBusquedaOnline() {
    try {
      _crearFiltroUsuarios(false);
      _filtarReportesServidor(true);
    } finally { }
  }

  Future<void> _actualizarPassword() async {
    try {
      if(!_validarFormActualizarPassword()) {
        return;
      }
      isBusy();
      var loginForm = LoginForm(
        usuario: usuarioMenu,
        password: nuevaPassword.text,
      );
      var result = await loginRepository.actualizarPasswordAsync(loginForm);
      if(result == null || !result) {
        throw Exception();
      }
      await tool.wait(1);
      tool.closeBottomSheet();
      msg('Usuario actualizado. Ya puede iniciar sesión con su nueva contraseña.', MsgType.success);
    } catch(e) {
      msg('Ocurrio un error al intentar actualizar contraseña', MsgType.error);
      return;
    }
  }

  Future<void> dateSelected() async {
    if(cargandoReportes) {
      return;
    }
    update();
    await _obtenerReportesServidor();
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
    } else if(reporte.tipo! == "Daños") {
      daniosForm.version.text = reporte.reporteDanio!.version!;
      daniosForm.clave.text = reporte.reporteDanio!.clave!;
      daniosForm.fechaReporte.text = reporte.reporteDanio!.fechaReporte!;
      daniosForm.lineaNaviera.text = reporte.reporteDanio!.lineaNaviera!;
      daniosForm.cliente.text = reporte.reporteDanio!.cliente!;
      daniosForm.numContenedor.text = reporte.reporteDanio!.numContenedor!;
      daniosForm.vacio = reporte.reporteDanio!.vacio! == "X";
      daniosForm.lleno = reporte.reporteDanio!.lleno! == "X";
      daniosForm.d20 = reporte.reporteDanio!.d20! == "X";
      daniosForm.d40 = reporte.reporteDanio!.d40! == "X";
      daniosForm.hc = reporte.reporteDanio!.hc! == "X";
      daniosForm.otro = reporte.reporteDanio!.otro! == "X";
      daniosForm.estandar = reporte.reporteDanio!.estandar! == "X";
      daniosForm.opentop = reporte.reporteDanio!.opentop! == "X";
      daniosForm.flatRack = reporte.reporteDanio!.flatRack! == "X";
      daniosForm.reefer = reporte.reporteDanio!.reefer! == "X";
      daniosForm.reforzado = reporte.reporteDanio!.reforzado! == "X";
      daniosForm.numSello.text = reporte.reporteDanio!.numSello!;
      daniosForm.intPuertasIzq.text = reporte.reporteDanio!.intPuertasIzq!;
      daniosForm.intPuertasDer.text = reporte.reporteDanio!.intPuertasDer!;
      daniosForm.intPiso.text = reporte.reporteDanio!.intPiso!;
      daniosForm.intTecho.text = reporte.reporteDanio!.intTecho!;
      daniosForm.intPanelLateralIzq.text = reporte.reporteDanio!.intPanelLateralIzq!;
      daniosForm.intPanelLateralDer.text = reporte.reporteDanio!.intPanelLateralDer!;
      daniosForm.intPanelFondo.text = reporte.reporteDanio!.intPanelFondo!;
      daniosForm.extPuertasIzq.text = reporte.reporteDanio!.extPuertasIzq!;
      daniosForm.extPuertasDer.text = reporte.reporteDanio!.extPuertasDer!;
      daniosForm.extPoste.text = reporte.reporteDanio!.extPoste!;
      daniosForm.extPalanca.text = reporte.reporteDanio!.extPalanca!;
      daniosForm.extGanchoCierre.text = reporte.reporteDanio!.extGanchoCierre!;
      daniosForm.extPanelIzq.text = reporte.reporteDanio!.extPanelIzq!;
      daniosForm.extPanelDer.text = reporte.reporteDanio!.extPanelDer!;
      daniosForm.extPanelFondo.text = reporte.reporteDanio!.extPanelFondo!;
      daniosForm.extCantonera.text = reporte.reporteDanio!.extCantonera!;
      daniosForm.extFrisa.text = reporte.reporteDanio!.extFrisa!;
      daniosForm.observaciones.text = reporte.reporteDanio!.observaciones!;
    }
  }

  void _abrirVista(String ruta, [dynamic arguments]) {
    Get.toNamed(
      ruta,
      arguments: arguments,
    );
  }

  void _cargarTipoReporteBusquedaLista() {
    listaTiposReportes = [];
    for (var i = 0; i < tiposReporte.length; i++) {
      listaTiposReportes.add(
        BottomSheetAction(
          title: ComboText(
            texto: tiposReporte[i],
            fontWeight: tipoReporteSelected == tiposReporte[i]
              ? FontWeight.bold
              : FontWeight.normal,
          ),
          onPressed: (context) {
            tipoReporteBusqueda.text = tiposReporte[i];
            tipoReporteSelected = tiposReporte[i];
            update();
            Navigator.of(context).pop();
            _filtrarTipoReporteBusquedaOnline();
          },
        ),
      );
    }
  }

  bool _validarFormActualizarPassword() {
    var correcto = false;
    var mensaje = "";
    if(tool.isNullOrEmpty(nuevaPassword)) {
      mensaje = "Escriba la nueva contraseña";
    } else if(tool.isNullOrEmpty(repetirPassword)) {
      mensaje = "Escriba repetir contraseña";
    } else if(nuevaPassword.text != repetirPassword.text) {
      mensaje = "Las contraseñas NO coinciden";
    } else {
      correcto = true;
    }
    if(!correcto) {
      toast(mensaje);
    }
    return correcto;
  }

  Future<void> _validarEstatusUsuario() async {
    try {
      var online = await tool.isOnline();
      if(!online) {
        return;
      }
      var estatus = await usuariosRepository.verificarEstatusAsync(usuarioMenu);
      if(estatus == null) {
        return;
      }
      if(estatus != Literals.statusActivo) {
        Get.offAll(
          const LoginPage(),
          binding: LoginBinding(),
          transition: Transition.leftToRight,
          duration: 1.seconds,
        );
        msg("Su usuario se encuentra INACTIVO. Consulte con su administrador", MsgType.warning);
      }
    } finally { }
  }
}
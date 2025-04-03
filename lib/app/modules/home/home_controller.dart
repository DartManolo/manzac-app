import 'dart:io';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/system/menu_opciones.dart';
import '../../routes/app_routes.dart';
import '../../utils/get_injection.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class HomeController extends GetInjection {
  List<MenuOpciones> menuOpciones = [];

  String nombreMenu = "";
  String usuarioMenu = "";

  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  @override void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    try {
      menuOpciones = [
        MenuOpciones(
          titulo: "Entradas",
          icono: MaterialCommunityIcons.contain_start,
          accion: () => _abrirVista(AppRoutes.reporteEntrada),
        ),
        MenuOpciones(
          titulo: "Salidas",
          icono: MaterialCommunityIcons.contain_end,
          accion: () => _abrirVista(AppRoutes.reporteSalida),
        ),
        MenuOpciones(
          titulo: "Registro de daños",
          icono: MaterialCommunityIcons.truck_cargo_container,
          accion: () => _abrirVista(AppRoutes.reporteDanios),
        ),
      ];
      var arguments = Get.arguments;
      nombreMenu = arguments['nombre'] ?? "";
      usuarioMenu = arguments['usuario'] ?? "";
    } finally {
      update();
    }
  }

  Future<void> cerrarSesion() async {
    try {
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

  Future<void> tomarFotografiadddd() async {
    try {
      isBusy();
      var fotoCamara = await seleccionarFoto.pickImage(
        source: ImageSource.camera,
      );
      tool.debug(fotoCamara);
      if (fotoCamara != null) {
        var fotoTemp = File(fotoCamara.path);
        fotografia = await tool.imagenResize(fotoTemp);
        var base64Foto = await tool.imagen2base64(fotografia);
        tool.debug("------------------------- BASE64 -------------------------");
        tool.debug(base64Foto);
        isBusy(false);
        Get.toNamed(
          AppRoutes.reportes,
          arguments: {
            'base64Img' : base64Foto,
          },
        );
      }
    } finally {
      update();
      isBusy(false);
    }
  }

  void _abrirVista(String ruta) {
    Get.toNamed(
      ruta
    );
  }
}
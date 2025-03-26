import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/system/menu_opciones.dart';
import '../../utils/get_injection.dart';
import '../login/login_binding.dart';
import '../login/login_page.dart';

class HomeController extends GetInjection {
  List<MenuOpciones> menuOpciones = [];

  String nombreMenu = "";
  String usuarioMenu = "";

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
          accion: () {},
        ),
        MenuOpciones(
          titulo: "Salidas",
          icono: MaterialCommunityIcons.contain_end,
          accion: () {},
        ),
        MenuOpciones(
          titulo: "Registro de daños",
          icono: MaterialCommunityIcons.truck_cargo_container,
          accion: () {}
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
}
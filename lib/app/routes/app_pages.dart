import 'package:get/get.dart';

import '../modules/alpha/alpha_binding.dart';
import '../modules/alpha/alpha_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/reporte/reporte_binding.dart';
import '../modules/reporte/reporte_page.dart';
import '../modules/reporte_view/reporte_view_binding.dart';
import '../modules/reporte_view/reporte_view_page.dart';
import '../modules/usuarios/usuarios_binding.dart';
import '../modules/usuarios/usuarios_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.alpha,
      page: () => const AlphaPage(),
      binding: AlphaBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.reporteView,
      page: () => const ReporteViewPage(),
      binding: ReporteViewBinding(),
    ),
    GetPage(
      name: AppRoutes.reporte,
      page: () => const ReportePage(),
      binding: ReporteBinding(),
    ),
    GetPage(
      name: AppRoutes.usuarios,
      page: () => const UsuariosPage(),
      binding: UsuariosBinding(),
    ),
  ];
}
import 'package:get/get.dart';

import '../modules/alpha/alpha_binding.dart';
import '../modules/alpha/alpha_page.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/reporte_danios/reporte_danios_binding.dart';
import '../modules/reporte_danios/reporte_salida_page.dart';
import '../modules/reporte_entrada/reporte_entrada_binding.dart';
import '../modules/reporte_entrada/reporte_entrada_page.dart';
import '../modules/reporte_salida/reporte_salida_binding.dart';
import '../modules/reporte_salida/reporte_salida_page.dart';
import '../modules/reportes/reportes_binding.dart';
import '../modules/reportes/reportes_page.dart';
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
      name: AppRoutes.reportes,
      page: () => const ReportesPage(),
      binding: ReportesBinding(),
    ),
    GetPage(
      name: AppRoutes.reporteEntrada,
      page: () => const ReporteEntradaPage(),
      binding: ReporteEntradaBinding(),
    ),
    GetPage(
      name: AppRoutes.reporteSalida,
      page: () => const ReporteSalidaPage(),
      binding: ReporteSalidaBinding(),
    ),
    GetPage(
      name: AppRoutes.reporteDanios,
      page: () => const ReporteDaniosPage(),
      binding: ReporteDaniosBinding(),
    ),
  ];
}
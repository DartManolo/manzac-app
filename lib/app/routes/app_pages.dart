import 'package:get/get.dart';

import '../modules/alpha/alpha_binding.dart';
import '../modules/alpha/alpha_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.alpha,
      page: () => const AlphaPage(),
      binding: AlphaBinding(),
    ),
  ];
}
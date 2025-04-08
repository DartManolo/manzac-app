import 'package:get/get.dart';

import 'reporte_view_controller.dart';

class ReporteViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteViewController());
  }
}
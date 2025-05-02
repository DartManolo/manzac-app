import 'package:get/get.dart';

import 'reporte_controller.dart';

class ReporteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteController());
  }
}
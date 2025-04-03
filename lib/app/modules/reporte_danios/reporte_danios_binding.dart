import 'package:get/get.dart';

import 'reporte_danios_controller.dart';

class ReporteDaniosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteDaniosController());
  }
}
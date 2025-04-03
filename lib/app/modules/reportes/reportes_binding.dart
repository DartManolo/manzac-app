import 'package:get/get.dart';

import 'reportes_controller.dart';

class ReportesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportesController());
  }
}
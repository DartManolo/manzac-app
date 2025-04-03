import 'package:get/get.dart';

import 'reporte_salida_controller.dart';

class ReporteSalidaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteSalidaController());
  }
}
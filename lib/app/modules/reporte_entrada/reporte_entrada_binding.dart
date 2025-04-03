import 'package:get/get.dart';

import 'reporte_entrada_controller.dart';

class ReporteEntradaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReporteEntradaController());
  }
}
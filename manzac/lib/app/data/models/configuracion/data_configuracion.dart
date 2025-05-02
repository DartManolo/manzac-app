import 'package:get/get.dart';

import '../../../services/tool_service.dart';

class DataConfiguracion {
  final ToolService tool = Get.find<ToolService>();
  String? firmaOperador;
  String? firmaGerencia;

  DataConfiguracion({
    this.firmaOperador = "",
    this.firmaGerencia = "",
  });

  Map toJson() => {
    'firmaOperador' : firmaOperador,
    'firmaGerencia' : firmaGerencia,
  };

  DataConfiguracion.fromApi(Map<String, dynamic> json) {
    firmaOperador = json['firmaOperador'].toString();
    firmaGerencia = json['firmaGerencia'].toString();
  }
}
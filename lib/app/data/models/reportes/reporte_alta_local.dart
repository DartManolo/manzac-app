import 'dart:convert';

import 'package:get/get.dart';

import '../../../services/storage_service.dart';
import 'reporte_entrada.dart';
import 'reporte_salida.dart';

class ReporteAltaLocal {
  String? tabla = "reporte_alta_local";
  String? tipo;
  ReporteEntrada? reporteEntrada;
  ReporteSalida? reporteSalida;

  ReporteAltaLocal({
    this.tipo,
    this.reporteEntrada,
    this.reporteSalida,
  });

  static Future<void> init() async {
    try {
      var storage = Get.find<StorageService>();
      var verify = await storage.verify(ReporteAltaLocal());
      if(!verify) {
        var _ = await storage.put([ReporteAltaLocal()]);
      }
      return;
    } finally { }
  }

  Map toJson() => {
    'tabla' : tabla,
    'tipo' : tipo,
    'reporteEntrada' : reporteEntrada,
    'reporteSalida' : reporteSalida,
  };

  ReporteAltaLocal fromJson(Map<String, dynamic>? json) {
    return json != null ? ReporteAltaLocal(
      tipo: json['tipo'] ?? "",
      reporteEntrada: jsonDecode(jsonEncode(json['reporteEntrada'])) ?? ReporteEntrada(),
      reporteSalida: jsonDecode(jsonEncode(json['reporteSalida'])) ?? ReporteSalida(),
    ) : ReporteAltaLocal();
  }

  List<ReporteAltaLocal> fromArray(List<dynamic>? array) {
    if(array != null) {
      List<ReporteAltaLocal> jsonArray = [];
      for(var json in array) {
        ReporteEntrada? reporteEntrada;
        ReporteSalida? reporteSalida;
        if(json['reporteEntrada'] != null) {
          reporteEntrada = ReporteEntrada.fromMap(jsonDecode(jsonEncode(json['reporteEntrada'])));
        }
        if(json['reporteSalida'] != null) {
          reporteSalida = ReporteSalida.fromMap(jsonDecode(jsonEncode(json['reporteSalida'])));
        }
        jsonArray.add(ReporteAltaLocal(
          tipo: json['tipo'] ?? "",
          reporteEntrada:  reporteEntrada,
          reporteSalida: reporteSalida,
        ));
      }
      return jsonArray;
    }
    return [ReporteAltaLocal()];
  }
}
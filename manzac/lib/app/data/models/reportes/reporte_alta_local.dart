import 'dart:convert';

import 'package:hive_ce_flutter/adapters.dart';

import '../hive_model.dart';
import 'reporte_danio.dart';
import 'reporte_entrada.dart';
import 'reporte_salida.dart';

part 'reporte_alta_local.g.dart';

@HiveType(typeId: 1)
class ReporteAltaLocal extends HiveModel {
  static const String boxName = "reporte_alta_local";

  @HiveField(0)
  @override
  String? id;

  @HiveField(1)
  String? tipo;
  
  @HiveField(2)
  ReporteEntrada? reporteEntrada;
  
  @HiveField(3)
  ReporteSalida? reporteSalida;
  
  @HiveField(4)
  ReporteDanio? reporteDanio;

  ReporteAltaLocal({
    this.id,
    this.tipo,
    this.reporteEntrada,
    this.reporteSalida,
    this.reporteDanio,
  });

  Map<String, dynamic> toJson() => {
    'id'              : id,
    'tipo'            : tipo,
    'reporteEntrada'  : reporteEntrada?.toJson(),
    'reporteSalida'   : reporteSalida?.toJson(),
    'reporteDanio'    : reporteDanio?.toJson(),
  };

  ReporteAltaLocal fromJson(Map<String, dynamic>? json) {
    return json != null ? ReporteAltaLocal(
      tipo: json['tipo'] ?? "",
      reporteEntrada: jsonDecode(jsonEncode(json['reporteEntrada'])) ?? ReporteEntrada(),
      reporteSalida: jsonDecode(jsonEncode(json['reporteSalida'])) ?? ReporteSalida(),
      reporteDanio: jsonDecode(jsonEncode(json['reporteDanio'])) ?? ReporteDanio(),
    ) : ReporteAltaLocal();
  }

  List<ReporteAltaLocal> fromArray(List<dynamic>? array) {
    if(array != null) {
      List<ReporteAltaLocal> jsonArray = [];
      for(var json in array) {
        ReporteEntrada? reporteEntrada;
        ReporteSalida? reporteSalida;
        ReporteDanio? reporteDanio;
        if(json['reporteEntrada'] != null) {
          reporteEntrada = ReporteEntrada.fromMap(jsonDecode(jsonEncode(json['reporteEntrada'])));
        }
        if(json['reporteSalida'] != null) {
          reporteSalida = ReporteSalida.fromMap(jsonDecode(jsonEncode(json['reporteSalida'])));
        }
        if(json['reporteDanio'] != null) {
          reporteDanio = ReporteDanio.fromMap(jsonDecode(jsonEncode(json['reporteDanio'])));
        }
        jsonArray.add(ReporteAltaLocal(
          tipo: json['tipo'] ?? "",
          reporteEntrada:  reporteEntrada,
          reporteSalida: reporteSalida,
          reporteDanio: reporteDanio,
        ));
      }
      return jsonArray;
    }
    return [ReporteAltaLocal()];
  }

  ReporteAltaLocal.fromApi(Map<String, dynamic> json) {
    ReporteEntrada? entrada;
    ReporteSalida? salida;
    ReporteDanio? danio;
    if(json['reporteEntrada'] != null) {
      entrada = ReporteEntrada.fromMap(jsonDecode(jsonEncode(json['reporteEntrada'])));
    }
    if(json['reporteSalida'] != null) {
      salida = ReporteSalida.fromMap(jsonDecode(jsonEncode(json['reporteSalida'])));
    }
    if(json['reporteDanio'] != null) {
      danio = ReporteDanio.fromMap(jsonDecode(jsonEncode(json['reporteDanio'])));
    }
    tipo = json['tipo'].toString();
    reporteEntrada = entrada;
    reporteSalida = salida;
    reporteDanio = danio;
  }
}
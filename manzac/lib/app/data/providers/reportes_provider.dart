import 'dart:convert';

import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../services/tool_service.dart';
import '../../utils/literals.dart';
import '../models/reportes/reporte_alta_local.dart';
import '../models/reportes/reporte_imagenes.dart';

class ReportesProvider {
  final ApiService _api = Get.find<ApiService>();
  final ToolService _tool = Get.find<ToolService>();

  Future<bool> altaReporteAsync(List<ReporteAltaLocal> reportes) async {
    try {
      var result = await _api.post(
        "api/reportes/alta",
        reportes,
      );
      return result == Literals.apiTrue;
    } catch(e) {
      return false;
    }
  }

  Future<List<ReporteAltaLocal>?> consultaReporteAsync(String parametro) async {
    try {
      var resultApi = await _api.get(
        "api/reportes/consulta/$parametro"
      );
      Iterable apiResultJson = json.decode(resultApi!);
      var result = List<ReporteAltaLocal>.from(
        apiResultJson.map((json) => ReporteAltaLocal.fromApi(json))
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<List<ReporteImagenes>?> consultaImagenesReporteAsync(String idTarja) async {
    try {
      var resultApi = await _api.get(
        "api/reportes/imagenes/$idTarja"
      );
      Iterable apiResultJson = json.decode(resultApi!);
      var result = List<ReporteImagenes>.from(
        apiResultJson.map((json) => ReporteImagenes.fromApi(json))
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<List<ReporteImagenes>?> consultaImagenesEmptyReporteAsync(String idTarja) async {
    try {
      var resultApi = await _api.get(
        "api/reportes/imagenesEmpty/$idTarja"
      );
      Iterable apiResultJson = json.decode(resultApi!);
      var result = List<ReporteImagenes>.from(
        apiResultJson.map((json) => ReporteImagenes.fromApi(json))
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<List<ReporteImagenes>?> consultaImagenesPaginadoReporteAsync(String idTarja, int ini, int fin) async {
    try {
      var resultApi = await _api.get(
        "api/reportes/imagenesPaginado/$idTarja/$ini/$fin"
      );
      Iterable apiResultJson = json.decode(resultApi!);
      var result = List<ReporteImagenes>.from(
        apiResultJson.map((json) => ReporteImagenes.fromApi(json))
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<int> consultaImagenesContadorReporteAsync(String idTarja) async {
    try {
      var result = await _api.get(
        "api/reportes/imagenesContador/$idTarja"
      );
      return _tool.str2int(result!);
    } catch(e) {
      return -1;
    }
  }
}
import 'dart:convert';

import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../utils/literals.dart';
import '../models/reportes/reporte_alta_local.dart';
import '../models/reportes/reporte_imagenes.dart';

class ReportesProvider {
  final ApiService _api = Get.find<ApiService>();

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
}
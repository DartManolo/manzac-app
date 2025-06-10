import 'package:get/get.dart';

import '../models/reportes/reporte_alta_local.dart';
import '../models/reportes/reporte_imagenes.dart';
import '../providers/reportes_provider.dart';

class ReportesRepository {
  Future<bool> altaReporteAsync(List<ReporteAltaLocal> reportes) async {
    return await Get.find<ReportesProvider>().altaReporteAsync(reportes);
  }

  Future<List<ReporteAltaLocal>?> consultaReporteAsync(String parametro) async {
    return await Get.find<ReportesProvider>().consultaReporteAsync(parametro);
  }

  Future<List<ReporteImagenes>?> consultaImagenesReporteAsync(String idTarja) async {
    return await Get.find<ReportesProvider>().consultaImagenesReporteAsync(idTarja);
  }

  Future<List<ReporteImagenes>?> consultaImagenesEmptyReporteAsync(String idTarja) async {
    return await Get.find<ReportesProvider>().consultaImagenesEmptyReporteAsync(idTarja);
  }
  
  Future<List<ReporteImagenes>?> consultaImagenesPaginadoReporteAsync(String idTarja, int ini, int fin) async {
    return await Get.find<ReportesProvider>().consultaImagenesPaginadoReporteAsync(idTarja, ini, fin);
  }

  Future<int> consultaImagenesContadorReporteAsync(String idTarja) async {
    return await Get.find<ReportesProvider>().consultaImagenesContadorReporteAsync(idTarja);
  }
}
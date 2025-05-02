import 'dart:convert';

import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../utils/literals.dart';
import '../models/configuracion/data_configuracion.dart';

class ConfiguracionProvider {
  final ApiService _api = Get.find<ApiService>();

  Future<DataConfiguracion?> obtenerConfiguracionAsync(String tipo) async {
    try {
      var result = await _api.get(
        "api/configuracion/obtener/$tipo",
      );
      return DataConfiguracion.fromApi(jsonDecode(result!));
    } catch(e) {
      return null;
    }
  }

  Future<bool> guardarFirmaAsync(String nombre, String contenido) async {
    try {
      var data = {
        "nombre": nombre,
        "contenido": contenido
      };
      var result = await _api.post(
        "api/configuracion/altaFirma",
        data
      );
      return result == Literals.apiTrue;
    } catch(e) {
      return false;
    }
  }
}
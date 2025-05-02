import 'package:get/get.dart';

import '../models/configuracion/data_configuracion.dart';
import '../providers/configuracion_provider.dart';

class ConfiguracionRepository {
  Future<DataConfiguracion?> obtenerConfiguracionAsync(String tipo) async {
    return await Get.find<ConfiguracionProvider>().obtenerConfiguracionAsync(tipo);
  }

  Future<bool> guardarFirmaAsync(String nombre, String contenido) async {
    return await Get.find<ConfiguracionProvider>().guardarFirmaAsync(nombre, contenido);
  }
}
import 'package:get/get.dart';

import '../data/providers/configuracion_provider.dart';
import '../data/providers/login_provider.dart';
import '../data/providers/reportes_provider.dart';
import '../data/providers/usuarios_provider.dart';
import '../data/repositories/configuracion_repository.dart';
import '../data/repositories/login_repository.dart';
import '../data/repositories/reportes_repository.dart';
import '../data/repositories/usuarios_repository.dart';
import '../services/api_service.dart';
import '../services/firebase_service.dart';
import '../services/storage_service.dart';
import '../services/tool_service.dart';

class DependencyInjection {
  static void init() {
    Get.put<ToolService>(ToolService());
    Get.put<StorageService>(StorageService());
    Get.put<ApiService>(ApiService());
    Get.put<FirebaseService>(FirebaseService());

    Get.put<LoginProvider>(LoginProvider());
    Get.put<LoginRepository>(LoginRepository());
    Get.put<ConfiguracionProvider>(ConfiguracionProvider());
    Get.put<ConfiguracionRepository>(ConfiguracionRepository());
    Get.put<UsuariosProvider>(UsuariosProvider());
    Get.put<UsuariosRepository>(UsuariosRepository());
    Get.put<ReportesProvider>(ReportesProvider());
    Get.put<ReportesRepository>(ReportesRepository());
  }
}
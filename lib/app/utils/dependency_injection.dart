import 'package:get/get.dart';

import '../data/providers/login_provider.dart';
import '../data/repositories/login_repository.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/tool_service.dart';

class DependencyInjection {
  static void init() {
    Get.put<ToolService>(ToolService());
    Get.put<StorageService>(StorageService());
    Get.put<ApiService>(ApiService());

    Get.put<LoginProvider>(LoginProvider());
    Get.put<LoginRepository>(LoginRepository());
  }
}
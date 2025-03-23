import 'package:get/get.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/tool_service.dart';

class DependencyInjection {
  static void init() {
    Get.put<ToolService>(ToolService());
    Get.put<StorageService>(StorageService());
    Get.put<ApiService>(ApiService());
  }
}
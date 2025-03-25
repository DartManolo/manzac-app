import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/login_repository.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/tool_service.dart';
import '../widgets/dialogs/loading_dialog.dart';

abstract class GetInjection extends GetxController {
  final storage = Get.find<StorageService>();
  final tool = Get.find<ToolService>();
  final api = Get.find<ApiService>();

  static bool administrador = false;
  static String perfil = "";

  final loginRepository = Get.find<LoginRepository>();

  bool _loadingOpen = false;

  void isBusy([bool open = true]) {
    try {
      var thisContext = Get.context;
      if (!open && _loadingOpen) {
        try {
          Navigator.pop(thisContext!);
        } finally {}
      }
      _loadingOpen = open;
      if (open) {
        showDialog(
          context: thisContext!,
          barrierDismissible: true,
          builder: (BuildContext context) {
            context = context;
            return const LoadingDialog();
          },
        );
      }
    } finally {}
  }
}
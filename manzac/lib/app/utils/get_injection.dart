import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:manzac_app/app/widgets/dialogs/alerta_dialog.dart';

import '../data/models/reportes/reporte_alta_local.dart';
import '../data/repositories/configuracion_repository.dart';
import '../data/repositories/login_repository.dart';
import '../data/repositories/reportes_repository.dart';
import '../data/repositories/usuarios_repository.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/tool_service.dart';
import '../widgets/dialogs/loading_dialog.dart';
import '../widgets/dialogs/modal_dialog.dart';
import '../widgets/dialogs/pregunta_dialog.dart';
import 'color_list.dart';

abstract class GetInjection extends GetxController {
  final storage = Get.find<StorageService>();
  final tool = Get.find<ToolService>();
  final api = Get.find<ApiService>();

  final loginRepository = Get.find<LoginRepository>();
  final configuracionRepository = Get.find<ConfiguracionRepository>();
  final usuariosRepository = Get.find<UsuariosRepository>();
  final reportesRepository = Get.find<ReportesRepository>();

  static bool administrador = false;
  static String perfil = "";

  Future<void> localStorageClassInit() async {
    await ReporteAltaLocal.init();
    return;
  }

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

  void msg(String mensaje, [MsgType tipo = MsgType.help]) {
    try {
      var thisContext = Get.context;
      if (_loadingOpen) {
        isBusy(false);
      }
      int index = 0;
      if(tipo == MsgType.success) {
        index = 1;
      } else if(tipo == MsgType.warning) {
        index = 2;
      } else if(tipo == MsgType.error) {
        index = 3;
      }
      List<IconData> iconos = [
        MaterialIcons.help,
        MaterialIcons.check_circle,
        MaterialIcons.warning,
        MaterialIcons.error,
      ];
      List<int> colores = [
        ColorList.theme[0],
        ColorList.theme[1],
        ColorList.theme[2],
        ColorList.theme[3],
      ];
      showDialog(
        context: thisContext!,
        builder: (BuildContext context) {
          context = context;
          return AlertaDialog(
            mensaje: mensaje,
            icono: iconos[index < 4 ? index : 0],
            color: colores[index < 4 ? index : 0],
          );
        },
      );
    } finally {}
  }

  void toast([String msg = ""]) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Color(0xFFFFFFFF),
      fontSize: 16.0,
      webShowClose: true,
    );
  }

  Future<bool> ask(String mensaje, String pregunta,
      {String si = "Aceptar", String no = "Cancelar"}) async {
    try {
      var askDialog = Get.context!;
      bool respuesta = false;
      await showDialog(
          context: askDialog,
          builder: (BuildContext context) {
            context = context;
            return PreguntaDialog(
              mensaje: mensaje,
              pregunta: pregunta,
              siBoton: si,
              noBoton: no,
              respuesta: (resp) {
                respuesta = resp;
                Navigator.of(context).pop();
              },
            );
          });
      return respuesta;
    } catch (e) {
      return false;
    }
  }

  void modal({List<Widget> widgets = const [], double height = 150}) {
    var modalContext = Get.context!;
    showDialog(
      context: modalContext,
      builder: (BuildContext context) {
        context = context;
        return ModalDialog(
          widgets: widgets,
          height: height,
        );
      },
    );
  }

  void modalClose() {
    var altaContext = Get.context!;
    Navigator.of(altaContext).pop(true);
  }
}

enum MsgType {
  help,
  success,
  warning,
  error,
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/appbars/back_appbar.dart';
import 'usuarios_controller.dart';

class UsuariosPage extends StatelessWidget with WidgetsBindingObserver {
  const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsuariosController>(
      builder: (c) => Scaffold(
        backgroundColor: Color(ColorList.ui[1]),
        appBar: BackAppbar(
          fondo: ColorList.ui[1],
          cerrar: c.cerrar,
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
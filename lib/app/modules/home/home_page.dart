import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/drawers/header_drawer.dart';
import '../../widgets/drawers/item_drawer.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget with WidgetsBindingObserver {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => Scaffold(
        backgroundColor: Color(ColorList.ui[1]),
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(ColorList.ui[1]),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              HeaderDrawer(),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: c.menuOpciones.map((opcion) {
                    return ItemDrawer(
                      icon: opcion.icono!,
                      text: opcion.titulo,
                      accion: opcion.accion,
                    );
                  }).toList(),
                ),
              Expanded(child: SizedBox()),
              Divider(),
              ItemDrawer(
                icon: MaterialIcons.logout,
                text: 'Cerrar sesión',
                accion: c.cerrarSesion,
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
        body: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
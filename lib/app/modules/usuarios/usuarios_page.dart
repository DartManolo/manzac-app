import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';

import '../../utils/color_list.dart';
import '../../widgets/appbars/back_appbar.dart';
import '../../widgets/columns/loading_column.dart';
import '../../widgets/containers/titulo_container.dart';
import '../../widgets/forms/sin_internet_form.dart';
import '../../widgets/forms/sin_usuarios_form.dart';
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
        body: Builder(
          builder: (context) {
            if(!c.cargando) {
              if(c.conInternet) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TituloContainer(
                      texto: "Registro de usuarios",
                      size: 18,
                    ),
                    Builder(
                      builder: (context) {
                        if(c.listaUsuarios.isNotEmpty) {
                          return Expanded(
                            child: SizedBox(),
                          );
                        } else {
                          return SinUsuariosForm(
                            recargar: c.recargar,
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return SinInternetForm(
                  recargar: c.recargar,
                );
              }
            } else {
              return LoadingColumn(
                mensaje: "Cargando usuarios...",
              );
            }
          },
        ),
        floatingActionButton: Visibility(
          visible: !c.cargando,
          child: FloatingActionButton(
            onPressed: c.nuevoUsuarioForm,
            shape: const CircleBorder(),
            backgroundColor: Color(ColorList.sys[0]),
            child: Icon(
              Icons.person_add_alt_1_outlined,
              color: Color(ColorList.sys[2]).toMaterialColor(),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
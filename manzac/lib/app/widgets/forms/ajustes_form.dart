import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../../utils/literals.dart';
import '../buttons/card_button_container.dart';
import '../buttons/circular_buttons.dart';
import '../buttons/solid_button.dart';
import '../containers/card_container.dart';
import '../containers/titulo_container.dart';
import '../defaults/small_header.dart';
import '../switchs/opcion_switch.dart';

class AjustesForm extends StatelessWidget {
  final ScrollController? scrollController;
  final void Function() cambiarPasswordForm;
  final void Function() reestablcerAplicacion;
  final void Function() obtenerFirmas;
  final bool esMayusculas;
  final void Function(bool) configMayusculas;
  final void Function(String) configFirma;
  final void Function(String) verFirma;
  final String idUsuarioMenu;
  final String usuarioMenu;
  final String nombreMenu;
  final String perfilMenu;
  final bool isAdmin;
  final bool notificaciones;
  final bool almacenamiento;
  final void Function(String) solicitarPermisoAjustes;
  const AjustesForm({
    super.key,
    required this.scrollController,
    required this.cambiarPasswordForm,
    required this.reestablcerAplicacion,
    required this.obtenerFirmas,
    this.esMayusculas = false,
    required this.configMayusculas,
    required this.configFirma,
    required this.verFirma,
    this.idUsuarioMenu = "",
    this.usuarioMenu = "",
    this.nombreMenu = "",
    this.perfilMenu = "",
    this.isAdmin = false,
    this.notificaciones = false,
    this.almacenamiento = false,
    required this.solicitarPermisoAjustes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder: (context, isScrolled) {
              return [const SmallHeader(height: 0)];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TituloContainer(
                    texto: 'Información del usuario',
                    size: 18,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CardContainer(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: const EdgeInsets.all(15),
                    children: [
                      Text(
                        'Id de usuario:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      Text(
                        idUsuarioMenu,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Usuario de acceso:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      AutoSizeText(
                        usuarioMenu,
                        maxFontSize: 14,
                        minFontSize: 7,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nombre de registro:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      AutoSizeText(
                        nombreMenu,
                        maxFontSize: 14,
                        minFontSize: 7,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Perfil:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                      AutoSizeText(
                        perfilMenu,
                        maxFontSize: 14,
                        minFontSize: 7,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(ColorList.sys[0]),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: TituloContainer(
                    texto: 'Configurar reportes',
                    size: 18,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Cambiar automáticamente en mayúsculas todas las palabras de los reportes (solo la de los formularios escritos por el usuario).',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(ColorList.sys[0]),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: OpcionSwitch(
                          value: esMayusculas,
                          text: "",
                          onChanged: configMayusculas,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Firma Operaciones (Reporte de daños)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(ColorList.sys[0]),
                          ),
                        ),
                      ),
                      CircularButton(
                        icono: Icons.remove_red_eye_outlined,
                        colorIcono: ColorList.sys[0],
                        margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
                        onPressed: () => verFirma('OPERACIONES'),
                      ),
                      Visibility(
                        visible: isAdmin,
                        child: CircularButton(
                          icono: Icons.edit,
                          color: ColorList.sys[1],
                          colorIcono: ColorList.sys[3],
                          margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
                          onPressed: () => configFirma('OPERACIONES'),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          'Firma Gerencia (Reporte de daños)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(ColorList.sys[0]),
                          ),
                        ),
                      ),
                      CircularButton(
                        icono: Icons.remove_red_eye_outlined,
                        colorIcono: ColorList.sys[0],
                        margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
                        onPressed: () => verFirma('GERENCIA'),
                      ),
                      Visibility(
                        visible: isAdmin,
                        child: CircularButton(
                          icono: Icons.edit,
                          color: ColorList.sys[1],
                          colorIcono: ColorList.sys[3],
                          margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
                          onPressed: () => configFirma('GERENCIA'),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SolidButton(
                    texto: 'Obtener firmas del servidor',
                    icono: MaterialIcons.file_download,
                    fondoColor: ColorList.sys[3],
                    textoColor: ColorList.sys[0],
                    onPressed: obtenerFirmas,
                    onLongPress: () {},
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: TituloContainer(
                    texto: 'Permisos de la aplicación',
                    size: 18,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      if(notificaciones/* && almacenamiento*/) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                              child: AutoSizeText(
                                "No tiene permisos disponibles por asignar",
                                textAlign: TextAlign.justify,
                                maxFontSize: 12,
                                minFontSize: 12,
                                style: TextStyle(color: Color(ColorList.sys[0])),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Visibility(
                              visible: !notificaciones,
                              child: CardButtonContainer(
                                texto: "Recibir notificaciones",
                                icono: MaterialIcons.notifications,
                                onTap: () => solicitarPermisoAjustes("NOTIFICATIONS"),
                              ),
                            ),
                            /*Visibility(
                              visible: !almacenamiento,
                              child: CardButtonContainer(
                                texto: "Acceso al almacenamiento",
                                icono: MaterialIcons.storage,
                                onTap: () => solicitarPermisoAjustes("STORAGE"),
                              ),
                            ),*/
                          ],
                        );
                      }
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: TituloContainer(
                    texto: 'Contraseña de acceso',
                    size: 18,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SolidButton(
                    texto: 'Cambiar mi contraseña',
                    icono: MaterialIcons.lock_outline,
                    fondoColor: ColorList.sys[1],
                    textoColor: ColorList.sys[3],
                    onPressed: cambiarPasswordForm,
                    onLongPress: () {},
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: TituloContainer(texto: 'Manejo de sesión', size: 18),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: AutoSizeText(
                      Literals.advertenciaSalidaApp,
                      textAlign: TextAlign.justify,
                      maxFontSize: 12,
                      minFontSize: 12,
                      style: TextStyle(color: Color(ColorList.sys[0])),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SolidButton(
                    texto: 'Dejar presionado para salir',
                    icono: MaterialIcons.refresh,
                    fondoColor: ColorList.sys[0],
                    textoColor: ColorList.sys[3],
                    onPressed: () {},
                    onLongPress: reestablcerAplicacion,
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 15)),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Versión: ${Literals.version}",
                        style: TextStyle(
                          color: Color(0xFFAEB6BF),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 25)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

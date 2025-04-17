import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../../utils/literals.dart';
import '../buttons/solid_button.dart';
import '../containers/card_container.dart';
import '../containers/titulo_container.dart';
import '../defaults/small_header.dart';

class AjustesForm extends StatelessWidget {
  final ScrollController? scrollController;
  final void Function() cambiarPasswordForm;
  final void Function() reestablcerAplicacion;
  final String idUsuarioMenu;
  final String usuarioMenu;
  final String nombreMenu;
  final String perfilMenu;
  const AjustesForm({
    super.key,
    required this.scrollController,
    required this.cambiarPasswordForm,
    required this.reestablcerAplicacion,
    this.idUsuarioMenu = "",
    this.usuarioMenu = "",
    this.nombreMenu = "",
    this.perfilMenu = "",
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

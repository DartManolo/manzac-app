import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../data/models/login/login_data.dart';
import '../../utils/color_list.dart';
import '../../utils/literals.dart';
import '../buttons/circular_buttons.dart';
import '../containers/card_container.dart';
import '../defaults/small_header.dart';

class UsuariosForm extends StatelessWidget {
  final ScrollController? scrollController;
  final List<LoginData> usuarios;
  final bool usarGaleria;
  final void Function(LoginData?, String) cambiarEstatus;
  const UsuariosForm({
    super.key,
    this.scrollController,
    this.usuarios = const [],
    this.usarGaleria = false,
    required this.cambiarEstatus,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [const SmallHeader(height: 0)];
        },
        body: CustomScrollView(
          controller: scrollController,
          slivers: usuarios.map((usuario) {
            return SliverToBoxAdapter(
              child: CardContainer(
                fondo: 0xFFC9CBCD,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CardContainer(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  columnAlign: CrossAxisAlignment.center,
                                  width: 50,
                                  radius: 10,
                                  children: [
                                    Icon(
                                      usuario.perfil == Literals.perfilAdministrador
                                        ? MaterialIcons.verified_user
                                        : MaterialIcons.person,
                                      color: Color(0xFF5D6D7E),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Usuario:  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  minFontSize: 7,
                                  maxLines: 1,
                                  usuario.usuario!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Perfil:  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  usuario.perfil!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Nombre:  ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  minFontSize: 7,
                                  maxLines: 1,
                                  "${usuario.nombres} ${usuario.apellidos}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color(ColorList.sys[0]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularButton(
                              colorIcono: ColorList.sys[3],
                              color: usuario.status! == Literals.statusInactivo
                                ? ColorList.theme[3]
                                : ColorList.theme[1],
                              icono: usuario.status! == Literals.statusInactivo
                                ? Icons.block
                                : Icons.check_circle_outline_outlined,
                              onPressed: () => cambiarEstatus(usuario,
                                usuario.status! == Literals.statusInactivo
                                  ? Literals.statusActivo
                                  : Literals.statusInactivo
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
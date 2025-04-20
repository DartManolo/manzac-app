import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../containers/card_container.dart';

class SinUsuariosForm extends StatelessWidget {
  final void Function() recargar;
  const SinUsuariosForm({
    super.key,
    required this.recargar,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
      padding: EdgeInsets.all(20),
      columnAlign: CrossAxisAlignment.center,
      fondo: ColorList.sys[2],
      children: [
        Icon(Icons.person_search_outlined, size: 45, color: Color(0xFF515A5A)),
        AutoSizeText(
          'No tiene usuarios registrados aún.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF515A5A),
          ),
        ),
        SolidButton(
          ltrbm: const [0, 20, 0, 0],
          fondoColor: ColorList.sys[1],
          textoColor: ColorList.sys[2],
          icono: Icons.refresh,
          texto: "Consultar de nuevo",
          onPressed: recargar,
          onLongPress: () {},
        ),
      ],
    );
  }
}
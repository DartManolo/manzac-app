import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/circular_buttons.dart';

class MoverFilaForm extends StatelessWidget {
  final void Function() filaArriba;
  final void Function() filaAbajo;
  const MoverFilaForm({
    super.key,
    required this.filaArriba,
    required this.filaAbajo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CircularButton(
                color: ColorList.sys[2],
                colorIcono: ColorList.sys[0],
                icono: FontAwesome5Solid.chevron_up,
                onPressed: filaArriba,
              ),
            ),
            Expanded(
              child: CircularButton(
                color: ColorList.sys[2],
                colorIcono: ColorList.sys[0],
                icono: FontAwesome5Solid.chevron_down,
                onPressed: filaAbajo,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Mover arriba",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
            Expanded(
              child: Text(
                "Mover abajo",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../containers/card_container.dart';

class SinReportesLocalForm extends StatelessWidget {
  final void Function() onPressed;
  const SinReportesLocalForm({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardContainer(
          padding: const EdgeInsets.all(20),
          columnAlign: CrossAxisAlignment.center,
          margin: const EdgeInsets.fromLTRB(15, 30, 15, 10),
          children: [
            Text(
              'No tiene reportes almacenados de forma local para guardar al servidor',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(ColorList.sys[0]),
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              MaterialIcons.file_upload,
              size: 35,
              color: Color(ColorList.sys[0]),
            ),
          ],
        ),
        SolidButton(
          texto: "Recargar listado de pendientes",
          icono: MaterialIcons.refresh,
          fondoColor: ColorList.sys[1],
          textoColor: ColorList.sys[3],
          onPressed: onPressed,
          onLongPress: () { },
        ),
      ],
    );
  }
}
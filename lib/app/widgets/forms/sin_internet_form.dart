import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../containers/card_container.dart';

class SinInternetForm extends StatelessWidget {
  final void Function() recargar;
  const SinInternetForm({
    super.key,
    required this.recargar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardContainer(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
          padding: EdgeInsets.all(20),
          columnAlign: CrossAxisAlignment.center,
          fondo: ColorList.sys[2],
          children: [
            Icon(Icons.cloud_off_outlined, size: 45, color: Color(0xFF515A5A)),
            AutoSizeText(
              'Al parecer no tiene conexión a Internet, intente conectarse a su red Wifi o datos móviles para utilizar esta función...',
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
              texto: "Volver a intentar",
              onPressed: recargar,
              onLongPress: () {},
            ),
          ],
        ),
      ],
    );
  }
}
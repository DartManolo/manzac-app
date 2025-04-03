import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../containers/card_container.dart';

class SinGaleriaForm extends StatelessWidget {
  const SinGaleriaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: const EdgeInsets.all(20),
      columnAlign: CrossAxisAlignment.center,
      margin: const EdgeInsets.fromLTRB(15, 30, 15, 10),
      children: [
        Text(
          'No tiene imágenes agregadas para el reporte',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Color(ColorList.sys[0]),
            fontWeight: FontWeight.w600,
          ),
        ),
        Icon(
          MaterialIcons.file_present,
          size: 35,
          color: Color(ColorList.sys[0]),
        ),
      ],
    );
  }
}
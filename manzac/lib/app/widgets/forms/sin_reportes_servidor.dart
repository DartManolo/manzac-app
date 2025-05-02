import 'package:flutter/material.dart';

import '../../utils/color_list.dart';
import '../containers/card_container.dart';

class SinReportesServidorForm extends StatelessWidget {
  const SinReportesServidorForm({super.key,});

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
              'No se mostraron resultados con la consulta realizada. Intente otros parámetros',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color(ColorList.sys[0]),
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.cloud_off_outlined,
              size: 35,
              color: Color(ColorList.sys[0]),
            ),
          ],
        ),
      ],
    );
  }
}
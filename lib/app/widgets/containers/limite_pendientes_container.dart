import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/color_list.dart';
import 'card_container.dart';

class LimitePendientesContainer extends StatelessWidget {
  final double reportesLocalSize;
  final double reportesLocalSizeLimit;
  const LimitePendientesContainer({
    super.key,
    required this.reportesLocalSize,
    required this.reportesLocalSizeLimit,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: reportesLocalSize > reportesLocalSizeLimit,
      child: CardContainer(
        fondo: 0xFFF9EBEA,
        margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
        padding: EdgeInsets.all(15),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 20,
                color: Color(ColorList.theme[3]),
              ),
            ],
          ),
          AutoSizeText(
            'El tamaño de la lista de reportes pendientes (${reportesLocalSize.toStringAsFixed(1)} MB), supera el límite soportado (${reportesLocalSizeLimit.toStringAsFixed(0)} MB). Si todos los pendientes son enviados al mismo tiempo podría ocasionar un error.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(ColorList.theme[3]),
              fontWeight: FontWeight.w700,
            ),
            maxFontSize: 12,
          ),
        ],
      ),
    );
  }
}

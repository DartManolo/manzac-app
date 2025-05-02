import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

class OpcionRadio extends StatelessWidget {
  final int value;
  final int groupValue;
  final String titulo;
  final int maxLines;
  final double minFontSize;
  final int textoColor;
  final int radioColor;
  final void Function(int?) onChanged;
  const OpcionRadio({
    super.key,
    this.value = 0,
    this.groupValue = 0,
    this.titulo = '',
    this.maxLines = 1,
    this.minFontSize = 9,
    required this.onChanged,
    this.textoColor = 0xFF566573,
    this.radioColor = 0xFF1F618D,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ListTile(
          title: AutoSizeText(
            titulo,
            maxLines: maxLines,
            minFontSize: minFontSize,
            style: TextStyle(
              color: Color(textoColor),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Radio<int>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
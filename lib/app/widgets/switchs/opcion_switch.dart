import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

class OpcionSwitch extends StatelessWidget {
  final bool value;
  final String text;
  final int textoColor;
  final int activeColor;
  final void Function(bool) onChanged;
  const OpcionSwitch({
    super.key,
    this.value = false,
    this.text = '',
    required this.onChanged,
    this.textoColor = 0xFF0A3D62,
    this.activeColor = 0xFF0A3D62,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          activeColor: Color(activeColor),
          onChanged: onChanged,
        ),
        AutoSizeText(
          text,
          minFontSize: 12,
          maxLines: 1,
          style: TextStyle(
            color: Color(textoColor),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
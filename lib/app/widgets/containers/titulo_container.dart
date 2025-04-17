import 'package:flutter/material.dart';

import '../../utils/color_list.dart';

class TituloContainer extends StatelessWidget {
  final String texto;
  final double size;
  final List<double> ltrbp;
  final bool bold;
  const TituloContainer({
    super.key,
    this.texto = '',
    this.size = 22,
    this.ltrbp = const [10, 10, 10, 10,],
    this.bold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ltrbp[0],
        ltrbp[1],
        ltrbp[2],
        ltrbp[3],
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: Color(ColorList.sys[0]),
        ),
      ),
    );
  }
}
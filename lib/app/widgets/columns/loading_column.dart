import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/color_list.dart';

class LoadingColumn extends StatelessWidget {
  final String mensaje;
  const LoadingColumn({
    super.key,
    this.mensaje = "Cargando información...",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SizedBox.shrink()),
        SpinKitThreeInOut(color: Color(ColorList.sys[1])),
        Text(
          mensaje,
          style: TextStyle(
            color: Color(ColorList.sys[0]),
            fontWeight: FontWeight.w800,
          ),
        ),
        Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}

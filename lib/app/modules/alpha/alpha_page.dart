import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import 'alpha_controller.dart';

class AlphaPage extends StatelessWidget with WidgetsBindingObserver {
  const AlphaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlphaController>(
      builder: (c) => Scaffold(
        backgroundColor: Color(ColorList.sys[0]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo-manzac.png'
                ),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitSpinningLines(
                  color: Color(ColorList.sys[2]),
                ),
              ],
            ),
            /*SizedBox(height: 100,),
            SolidButton(
              onPressed: c.tomarFotografia,
              onLongPress: () {},
            ),
            c.fotografia != null
              ? Image.file(c.fotografia!)
              : Text("No se ha tomado ninguna foto"),*/
          ],
        ),
      ),
    );
  }
}
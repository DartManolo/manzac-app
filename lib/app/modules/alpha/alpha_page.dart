import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/buttons/solid_button.dart';
import 'alpha_controller.dart';

class AlphaPage extends StatelessWidget with WidgetsBindingObserver {
  const AlphaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlphaController>(
      builder: (c) => Scaffold(
        backgroundColor: Color(ColorList.sys[0]),
        body: Column(
          children: [
            SizedBox(height: 100,),
            SolidButton(
              onPressed: c.tomarFotografia,
              onLongPress: () {},
            ),
            c.fotografia != null
              ? Image.file(c.fotografia!)
              : Text("No se ha tomado ninguna foto"),
          ],
        ),
      ),
    );
  }
}
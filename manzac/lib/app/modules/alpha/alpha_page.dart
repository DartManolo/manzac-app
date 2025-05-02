import 'package:animate_do/animate_do.dart';
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
                  'assets/logo-manzac.png',
                  scale: 3.5,
                ).fadeInLeft(delay: 1.seconds,),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitThreeInOut(
                  color: Color(ColorList.sys[2]),
                ).fadeIn(delay: 1.seconds,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
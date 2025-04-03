import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reporte_danios_controller.dart';

class ReporteDaniosPage extends StatelessWidget {
  const ReporteDaniosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReporteDaniosController>(
      builder: (c) => Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
            ],
          ),
          title: Text(""),
        ),
        body: TabBarView(
          children: [
            
          ],
        ),
      ),
    );
  }
}
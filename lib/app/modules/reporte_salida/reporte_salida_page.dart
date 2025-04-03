import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reporte_salida_controller.dart';

class ReporteSalidaPage extends StatelessWidget {
  const ReporteSalidaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReporteSalidaController>(
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import 'reportes_controller.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportesController>(
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(c.tituloVisor),
        ),
        body: PdfPreview(
          build: c.cargarPdf,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
        ),
      ),
    );
  }
}
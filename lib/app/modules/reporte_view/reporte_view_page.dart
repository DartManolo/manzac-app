import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../utils/color_list.dart';
import 'reporte_view_controller.dart';

class ReporteViewPage extends StatelessWidget {
  const ReporteViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReporteViewController>(
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(c.tituloVisor),
        ),
        body: PdfPreview(
          build: c.pdfReporte,
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          actionBarTheme: PdfActionBarTheme(
            backgroundColor: Color(ColorList.sys[0]),
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../utils/get_injection.dart';

class ReportesController extends GetInjection {
  String tituloVisor = "Vista previa PDF";
  String base64Image = "";

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() {
    var arguments = Get.arguments;
    base64Image = arguments['base64Img'];
  }

  Future<Uint8List> cargarPdf(PdfPageFormat format) async {
    var pdf = pw.Document();
    var imageBytes = base64Decode(base64Image);
    var image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text("Imagen en PDF", style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                  ],
                ),
              ],
            );
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> cargarPdf2(PdfPageFormat format) async {
    var pdf = pw.Document();
    var imageBytes = base64Decode(base64Image);
    var image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text("Imagen en PDF", style: pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 20),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.Image(
                        image,
                      ),
                    ),
                  ],
                ),
              ],
            );
        },
      ),
    );
    return pdf.save();
  }
}
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../data/models/reportes/reporte_imagenes.dart';
import '../../utils/get_injection.dart';
import '../../widgets/textformfields/danios_textformfield.dart';
import '../../widgets/textformfields/entrada_textformfield.dart';
import '../../widgets/textformfields/salida_textformfield.dart';

class ReporteViewController extends GetInjection {
  EntradaTextformfield entradaForm = EntradaTextformfield();
  SalidaTextformfield salidaForm = SalidaTextformfield();
  DaniosTextformfield daniosForm = DaniosTextformfield();
  
  String tituloVisor = "";
  String base64Image = "";
  String tipoReporte = "";
  String fechaReporte = "";
  String observacionesReporte = "";
  String imagenesTitulo = "";
  bool reporteNuevo = true;
  List<List<ReporteImagenes>> reporteImagenes = [];

  Uint8List? _pdfReport;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    var arguments = Get.arguments;
    tipoReporte = arguments['tipoReporte'];
    tituloVisor = "Reporte de $tipoReporte";
    if(arguments['reporteNuevo'] != null) {
      reporteNuevo = arguments['reporteNuevo'] as bool;
    }
    reporteImagenes = arguments['reporteImagenes'] as List<List<ReporteImagenes>>;
    if(tipoReporte == "Entrada") {
      entradaForm = arguments['formData'] as EntradaTextformfield;
    } else if(tipoReporte == "Salida") {
      salidaForm = arguments['formData'] as SalidaTextformfield;
    } else if(tipoReporte == "Daños") {
      daniosForm = DaniosTextformfield();
    } else {
      Get.back();
      return;
    }
    _crearDatosAdicionalesReporte();
  }

  Future<Uint8List> pdfReporte(PdfPageFormat format) async {
    try {
      if(tipoReporte == "Entrada" || tipoReporte == "Salida") {
        _pdfReport = await _reporteEstandar(format);
      }
      return _pdfReport!;
    } catch(e) {
      Get.back();
      msg("Ocurrió un error al cargar reporte", MsgType.error);
      return _pdfReport!;
    }
  }

  List<pw.TableRow> _reporteEstandarCuerpo() {
    List<pw.TableRow> cuerpo = [];
    if(tipoReporte == "Entrada") {
      cuerpo = [
        _filaTablaEstandar(
          ['Referencia LM', 'IMO', 'Hora Inicio', 'Hora de Fin'],
          fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
        _filaTablaEstandar(
          [
            _validaText(entradaForm.referenciaLm),
            _validaText(entradaForm.imo),
            _validaText(entradaForm.horaInicio),
            _validaText(entradaForm.horaFin)
          ]),
        _filaTablaEstandar(
          ['Cliente', 'Mercancia', 'Agente aduanal', 'Ejecutivo'],
          fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
        _filaTablaEstandar(
          [
            _validaText(entradaForm.cliente),
            _validaText(entradaForm.mercancia),
            _validaText(entradaForm.agenteAduanal),
            _validaText(entradaForm.ejecutivo)
          ]),
        _filaTablaEstandar(
          ['Contenedor y/o BL', 'Pedimento/Booking', 'Sello', 'Buque'],
          fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
        _filaTablaEstandar(
          [
            _validaText(entradaForm.contenedor),
            _validaText(entradaForm.pedimento),
            _validaText(entradaForm.sello),
            _validaText(entradaForm.buque)
          ]),
        _filaTablaEstandar(
          ['Referencia cliente', 'Bultos', 'Peso', 'Terminal'],
          fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
        _filaTablaEstandar(
          [
            _validaText(entradaForm.refCliente),
            _validaText(entradaForm.bultos),
            _validaText(entradaForm.peso),
            _validaText(entradaForm.terminal)
          ]),
        _filaTablaEstandar(
          ['Fecha Despacho', 'Días libres', 'Fecha vencimiento', 'Movimiento'],
          fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
        _filaTablaEstandar(
          [
            _validaText(entradaForm.fechaDespacho),
            _validaText(entradaForm.diasLibres),
            _validaText(entradaForm.fechaVencimiento),
            _validaText(entradaForm.movimiento)
          ]),
      ];
    } else if(tipoReporte == "Salida") {
        cuerpo = [
          _filaTablaEstandar(
            ['Referencia LM', 'IMO', 'Hora Inicio', 'Hora de Fin'],
            fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
          _filaTablaEstandar(
            [
              _validaText(salidaForm.referenciaLm),
              _validaText(salidaForm.imo),
              _validaText(entradaForm.horaInicio),
              _validaText(entradaForm.horaFin)
            ]),
          _filaTablaEstandar(
            ['Cliente', 'Mercancia', 'Agente aduanal', 'Ejecutivo'],
            fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
          _filaTablaEstandar(
            [
              _validaText(salidaForm.cliente),
              _validaText(salidaForm.mercancia),
              _validaText(salidaForm.agenteAduanal),
              _validaText(salidaForm.ejecutivo)
            ]),
          _filaTablaEstandar(
            ['Contenedor y/o BL', 'Pedimento/Booking', 'Sello', 'Buque'],
            fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
          _filaTablaEstandar(
            [
              _validaText(salidaForm.contenedor),
              _validaText(salidaForm.pedimento),
              _validaText(salidaForm.sello),
              _validaText(salidaForm.buque)
            ]),
          _filaTablaEstandar(
            ['Referencia cliente', 'Bultos', 'Peso', 'Terminal'],
            fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
          _filaTablaEstandar(
            [
              _validaText(salidaForm.refCliente),
              _validaText(salidaForm.bultos),
              _validaText(salidaForm.peso),
              _validaText(salidaForm.terminal)
            ]),
          _filaTablaEstandar(
            ['Transporte', 'Operador', 'Placas', 'Licencia'],
            fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
          _filaTablaEstandar(
            [
              _validaText(salidaForm.transporte),
              _validaText(salidaForm.operador),
              _validaText(salidaForm.placas),
              _validaText(salidaForm.licencia)
            ]),
        ];
    }
    return cuerpo;
  }

  Future<Uint8List> _reporteEstandar(PdfPageFormat format) async {
    final pdf = pw.Document();
    final imageBytes = await tool.loadAssetImage('assets/manzac-logo-doc1.png');
    final image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.fromLTRB(45, 40, 45, 40),
        build: (pw.Context context) {
          return [
            pw.Column(
              children: [
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(3.8),
                  },
                  children: [
                    _headerEstandar(image),
                  ],
                ),
                pw.Table(
                  border: pw.TableBorder.symmetric(
                    inside: pw.BorderSide.none,
                    outside: pw.BorderSide.none,
                  ),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(1.8),
                  },
                  children: [
                    _filaTablaEstandar(
                      ['          TIPO DE TARJA:', tipoReporte.toUpperCase(), 'FECHA', fechaReporte],
                      fontWeight: pw.FontWeight.bold, noBorder: true,),
                  ],
                ),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                    1: pw.FlexColumnWidth(1),
                    2: pw.FlexColumnWidth(1),
                    3: pw.FlexColumnWidth(1.8),
                  },
                  children: [
                    ..._reporteEstandarCuerpo(),
                  ],
                ),
                pw.SizedBox(height: 10,),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                  },
                  children: [
                    _filaTablaEstandar(['OBSERVACIONES'], fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
                    _filaTablaEstandar([observacionesReporte,], textAlign: pw.TextAlign.justify),
                  ],
                ),
                pw.SizedBox(height: 10,),
                pw.Table(
                  border: pw.TableBorder.all(),
                  columnWidths: {
                    0: pw.FlexColumnWidth(1),
                  },
                  children: [
                    _filaTablaEstandar(
                      [imagenesTitulo],
                      fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
                  ],
                ),
                pw.SizedBox(height: 10,),
              ],
            ),
            ...reporteImagenes.map((reporteImagen) {
                return pw.Row(
                  children: reporteImagen.map((imagen) {
                    return pw.Expanded(
                      child: pw.Builder(
                        builder: (context) {
                          if(imagen.base64 != "") {
                            var imageBytes = base64Decode(imagen.base64!);
                            var image = pw.MemoryImage(imageBytes);
                            return pw.Expanded(
                              child: pw.Container(
                                padding: pw.EdgeInsets.fromLTRB(3, 4, 3, 4),
                                child: pw.Image(
                                  image,
                                ),
                              ),
                            );
                          } else {
                            return pw.SizedBox();
                          }
                        }
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ];
        },
      ),
      
    );
    return pdf.save();
  }

  pw.TableRow _filaTablaEstandar(
    List<String> celdas,
    {
      double fontSize = 9,
      pw.FontWeight fontWeight = pw.FontWeight.normal,
      int color = 0xFF000000,
      pw.TextAlign textAlign = pw.TextAlign.center,
      int bgColor = 0xFFFFFFFF,
      bool noBorder = false,
      pw.EdgeInsets padding = const pw.EdgeInsets.all(5),
    }
  ) {
    return pw.TableRow(
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(bgColor),
        border: !noBorder
          ? pw.Border.symmetric(
            vertical: pw.BorderSide(width: 1),
            horizontal: pw.BorderSide(width: 1),
          )
          : pw.Border.all(
            style: pw.BorderStyle.none,
          ),
      ),
      children: celdas.map((celda) {
        return pw.Container(
          padding: padding,
          child: pw.Builder(
            builder: (context) {
              if(celda != '') {
                return pw.Container(
                  child: pw.Text(
                  celda,
                  textAlign: textAlign,
                  style: pw.TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: PdfColor.fromInt(color),
                  ),
                ),
                );
              } else {
                return pw.SizedBox();
              }
            },
          ),
        );
      }).toList(),
    );
  }

  pw.TableRow _headerEstandar(pw.MemoryImage image) {
    return pw.TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(5),
          height: 65,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Image(image,)
            ],
          ),
        ),
        pw.Text(
          "\nTARJA DE SERVICIOS\n",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _crearDatosAdicionalesReporte() {
    var inicio = tool.fecha('EEEE, dd');
    var mes = tool.fecha('MMMM');
    var anio = tool.fecha('y');
    fechaReporte = "$inicio de $mes de $anio";
    if(tipoReporte == "Entrada") {
      imagenesTitulo = "IMÁGENES DE LA DESCARGA";
      observacionesReporte = _validaText(entradaForm.observaciones);
    } else if(tipoReporte == "Salida") {
      imagenesTitulo = "IMÁGENES DE LA CARGA";
      observacionesReporte = _validaText(salidaForm.observaciones);
    }
  }

  String _validaText(TextEditingController controller) {
    var texto = controller.text;
    if(texto == "") {
      return "\n";
    }
    return texto;
  }
}

/*Future<Uint8List> cargarPdf(PdfPageFormat format) async {
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
    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (pw.Context context) {
          return [
            ...reporteImagenes.map((reporteImagen) {
                return pw.Row(
                  children: reporteImagen.map((imagen) {
                    return pw.Expanded(
                      child: pw.Builder(
                        builder: (context) {
                          if(imagen.base64 != "") {
                            var imageBytes = base64Decode(imagen.base64!);
                            var image = pw.MemoryImage(imageBytes);
                            return pw.Expanded(
                              child: pw.Image(
                                image,
                              ),
                            );
                          } else {
                            return pw.SizedBox();
                          }
                        }
                      ),
                    );
                  }).toList(),
                );
              }),
          ];
        },
      ),
    );
    return pdf.save();
  }*/
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

import '../../data/models/local_storage/local_storage.dart';
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
  LocalStorage? localStorage;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    var arguments = Get.arguments;
    tipoReporte = arguments['tipoReporte'];
    fechaReporte = arguments['fechaReporte'];
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
      daniosForm = arguments['formData'] as DaniosTextformfield;
    } else {
      Get.back();
      return;
    }
    localStorage = arguments['localStorage'] as LocalStorage;
    _crearDatosAdicionalesReporte();
  }

  Future<Uint8List> pdfReporte(PdfPageFormat format) async {
    try {
      if(tipoReporte == "Entrada" || tipoReporte == "Salida") {
        _pdfReport = await _reporteEstandar(format);
      } else if(tipoReporte == "Daños") {
        _pdfReport = await _reporteDanios(format);
      }
      return _pdfReport!;
    } catch(e) {
      Get.back();
      msg("Ocurrió un error al cargar reporte", MsgType.error);
      return _pdfReport!;
    }
  }

  Future<Uint8List> _reporteEstandar(PdfPageFormat format) async {
    final pdf = pw.Document();
    final logoBytes = await tool.loadAssetImage('assets/manzac-logo-doc2.png');
    final image = pw.MemoryImage(logoBytes);
    Map<String, Uint8List?> imagesBytes = {};
    for (var i = 0; i < reporteImagenes.length; i++) {
      for (var j = 0; j < reporteImagenes[i].length; j++) {
        Uint8List? imageBytes;
        if (_esUrl(reporteImagenes[i][j].imagen!)) {
          imageBytes = await _obtenerBytesDesdeUrl(reporteImagenes[i][j].imagen!);
        } else {
          try {
            final archivoImagen = File(reporteImagenes[i][j].imagen!);
            imageBytes = archivoImagen.readAsBytesSync();
          } catch(e) {
            imageBytes = null;
          }
        }
        imagesBytes[reporteImagenes[i][j].idImagen!] = imageBytes;
      }
    }
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
                          if(imagen.imagen != "") {
                            Uint8List? image = imagesBytes[imagen.idImagen];
                            if (image != null) {
                              return pw.Expanded(
                                child: pw.Container(
                                  padding: pw.EdgeInsets.fromLTRB(3, 4, 3, 4),
                                  child: pw.Image(
                                    pw.MemoryImage(image),
                                  ),
                                ),
                              );
                            } else {
                              return pw.SizedBox();
                            }
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

  Future<Uint8List> _reporteDanios(PdfPageFormat format) async {
    final pdf = pw.Document();
    final imageBytes = await tool.loadAssetImage('assets/manzac-logo-doc2.png');
    final image = pw.MemoryImage(imageBytes);
    final imageBytesContainer = await tool.loadAssetImage('assets/reporte_danios_contenedores.png');
    final imageContainer = pw.MemoryImage(imageBytesContainer);
    var imgFirmaOperaciones = await tool.loadAssetImage('assets/sin_firma.png');
    var imgFirmaGerencia = await tool.loadAssetImage('assets/sin_firma.png');
    if(localStorage!.firmaOperaciones != "") {
      imgFirmaOperaciones = base64Decode(localStorage!.firmaOperaciones!);
    }
    if(localStorage!.firmaGerencia != "") {
      imgFirmaGerencia = base64Decode(localStorage!.firmaGerencia!);
    }
    var version = daniosForm.version.text;
    if(version == "") {
      version = "0";
    } else {
      version = tool.str2int(version) < 10 ? "0$version" : version;
    }
    Map<String, Uint8List?> imagesBytes = {};
    for (var i = 0; i < reporteImagenes.length; i++) {
      for (var j = 0; j < reporteImagenes[i].length; j++) {
        Uint8List? imageBytes;
        if (_esUrl(reporteImagenes[i][j].imagen!)) {
          imageBytes = await _obtenerBytesDesdeUrl(reporteImagenes[i][j].imagen!);
        } else {
          try {
            final archivoImagen = File(reporteImagenes[i][j].imagen!);
            imageBytes = archivoImagen.readAsBytesSync();
          } catch(e) {
            imageBytes = null;
          }
        }
        imagesBytes[reporteImagenes[i][j].idImagen!] = imageBytes;
      }
    }
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: pw.EdgeInsets.fromLTRB(35, 20, 35, 20),
        build: (pw.Context context) {
          return [
            _headerReporteDanios(image, version),
            pw.SizedBox(height: 5,),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(1),
              },
              children: [
                _filaTablaEstandar(['INFORMACIÓN GENERAL'], fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
              ],
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(0.76),
                1: pw.FlexColumnWidth(1),
              },
              children: [
                _filaDaniosInfoGeneral(
                  [
                    'FECHA',
                    _validaText(daniosForm.fechaReporte),
                    'LÍNERA NAVIERA',
                    _validaText(daniosForm.lineaNaviera)
                  ],
                ),
                _filaDaniosInfoGeneral(
                  [
                    'CLIENTE',
                    _validaText(daniosForm.cliente),
                    'NÚMERO DE CONTENEDOR',
                    _validaText(daniosForm.numContenedor)
                  ],
                ),
              ],
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(1),
              },
              children: [
                _filaTablaEstandar(
                  ['                       CÓDIGOS DE DAÑO:                                                               TIPO DE CONTENEDOR:'],
                  fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,
                ),
              ],
            ),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(0.3),
                1: pw.FlexColumnWidth(0.7),
                2: pw.FlexColumnWidth(0.3),
                3: pw.FlexColumnWidth(0.75),
                4: pw.FlexColumnWidth(0.3),
                5: pw.FlexColumnWidth(0.55),
                6: pw.FlexColumnWidth(0.4),
                7: pw.FlexColumnWidth(0.2),
                8: pw.FlexColumnWidth(0.6),
                9: pw.FlexColumnWidth(1),
              },
              children: [
                _filaTablaEstandar(
                  [
                    'PI', 'HUNDIDO', 'B', 'DOBLADO', 'M', 'FALTA',
                    'VACÍO', daniosForm.vacio ? "X" : "\n", 'ESTÁNDAR', daniosForm.estandar ? "X" : "\n"
                  ], fontSize: 8, padding: pw.EdgeInsets.all(2),
                ),
                _filaTablaEstandar(
                  [
                    'PO', 'ADOMBADO', 'MN', 'DESPRENDIDO', 'R', 'OXIDADO',
                    'LLENO', daniosForm.lleno ? "X" : "\n", 'OPEN TOP', daniosForm.opentop ? "X" : "\n"
                  ], fontSize: 8, padding: pw.EdgeInsets.all(2),
                ),
                _filaTablaEstandar(
                  [
                    'D', 'ABOLLADO', 'BR', 'ROTO', 'DY', 'SUCIO',
                    '20\'', daniosForm.d20 ? "X" : "\n", 'FLAT RACK', daniosForm.flatRack ? "X" : "\n"
                  ], fontSize: 8, padding: pw.EdgeInsets.all(2),
                ),
                _filaTablaEstandar(
                  [
                    'SC', 'RASPADO', 'L', 'FLOJO', 'IR', 'REP-IMPRO.',
                    '40\'', daniosForm.d40 ? "X" : "\n", 'REEFER', daniosForm.reefer ? "X" : "\n"
                  ], fontSize: 8, padding: pw.EdgeInsets.all(2),
                ),
                _filaTablaEstandar(
                  [
                    'C', 'CORTADO', 'D', 'TORSIÓN', 'PT', 'PINTADO',
                    'HC', daniosForm.hc ? "X" : "\n", 'REFORZADO', daniosForm.reforzado ? "X" : "\n"
                  ], fontSize: 8, padding: pw.EdgeInsets.all(2),
                ),
                _filaTablaEstandar(
                  [
                    'H', 'PERFORADO', 'CR', 'RAJADO', 'XXX', 'OTRO',
                    'OTRO', daniosForm.otro ? "X" : "\n", 'SELLO N°', _validaText(daniosForm.numSello)
                  ], fontSize: 8, boldUltimo: true, padding: pw.EdgeInsets.all(2),
                ),
              ],
            ),
            pw.SizedBox(height: 5,),
            pw.Table(
              border: pw.TableBorder.all(),
              columnWidths: {
                0: pw.FlexColumnWidth(1),
              },
              children: [
                _filaTablaEstandar(['CONTENEDOR'], fontWeight: pw.FontWeight.bold, bgColor: 0xFFD9D9D9,),
                _filaDaniosTablaInterna(
                  children: [
                    pw.Image(imageContainer,),
                    pw.SizedBox(height: 5,),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                      },
                      children: [
                        _filaTablaEstandar(['INTERIOR'], fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
                      ],
                    ),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                        1: pw.FlexColumnWidth(0.8),
                        2: pw.FlexColumnWidth(0.8),
                        3: pw.FlexColumnWidth(1),
                        4: pw.FlexColumnWidth(0.7),
                      },
                      children: [
                        _filaTablaEstandar(
                          ['PUERTAS', 'PISO', 'TECHO', 'PANEL LATERAL', 'PANEL\nFONDO'],
                          fontWeight: pw.FontWeight.bold, padding: pw.EdgeInsets.all(2),
                        ),
                      ],
                    ),
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 124,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              0: pw.FlexColumnWidth(0.65),
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              _filaTablaEstandar(
                                ['IZQUIERDA', _validaText(daniosForm.intPuertasIzq)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start,
                              ),
                              _filaTablaEstandar(
                                ['DERECHA', _validaText(daniosForm.intPuertasDer)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 98.5,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              _filaTablaEstandar(
                                [_validaText(daniosForm.intPiso)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start, height: 26.5,
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 99,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              _filaTablaEstandar(
                                [_validaText(daniosForm.intTecho)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start, height: 26.5,
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 124,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              0: pw.FlexColumnWidth(0.65),
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              _filaTablaEstandar(
                                ['IZQUIERDA', _validaText(daniosForm.intPanelLateralIzq)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start,
                              ),
                              _filaTablaEstandar(
                                ['DERECHA', _validaText(daniosForm.intPanelLateralDer)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        pw.Container(
                          width: 86.5,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              _filaTablaEstandar(
                                [_validaText(daniosForm.intPanelFondo)],
                                fontSize: 8, padding: pw.EdgeInsets.all(2), textAlign: pw.TextAlign.start, height: 26.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5,),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(1),
                      },
                      children: [
                        _filaTablaEstandar(['EXTERIOR'], fontWeight: pw.FontWeight.bold, color: 0xFFFFFFFF, bgColor: 0xFF1F4E78,),
                      ],
                    ),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(0.7),
                        1: pw.FlexColumnWidth(1),
                        2: pw.FlexColumnWidth(0.55),
                        3: pw.FlexColumnWidth(1),
                      },
                      children: [
                        _filaDaniosExterior(
                          [
                            'PUERTA IZQUIERDA',
                            _validaText(daniosForm.extPuertasIzq),
                            'PANEL IZQUIERDO',
                            _validaText(daniosForm.extPanelIzq)
                          ],
                        ),
                        _filaDaniosExterior(
                          [
                            'PUERTA DERECHA',
                            _validaText(daniosForm.extPuertasDer),
                            'PANEL DERECHO',
                            _validaText(daniosForm.extPanelDer)
                          ],
                        ),
                        _filaDaniosExterior(
                          [
                            'POSTE',
                            _validaText(daniosForm.extPoste),
                            'PANEL FONDO',
                            _validaText(daniosForm.extPanelFondo)
                          ],
                        ),
                        _filaDaniosExterior(
                          [
                            'PALANCA',
                            _validaText(daniosForm.extPalanca),
                            'CANTONERA',
                            _validaText(daniosForm.extCantonera)
                          ],
                        ),
                        _filaDaniosExterior(
                          [
                            'GANCHO DE CIERRE',
                            _validaText(daniosForm.extGanchoCierre),
                            'FRISA',
                            _validaText(daniosForm.extFrisa)
                          ],
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.only(top: 5,),
                      child: pw.RichText(
                        textAlign: pw.TextAlign.justify,
                        text: pw.TextSpan(
                          text: 'OBSERVACIONES: ',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 9,
                          ),
                          children: [
                            pw.TextSpan(
                              text: _validaText(daniosForm.observaciones),
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 9,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    pw.Row(
                      children: [
                        pw.SizedBox(width: 40),
                        _firmaReporteDanios(imgFirmaOperaciones, 'FIRMA OPERACIONES'),
                        pw.Expanded(child: pw.SizedBox()),
                        _firmaReporteDanios(imgFirmaGerencia, 'GERENCIA'),
                        pw.SizedBox(width: 40),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ...reporteImagenes.map((reporteImagen) {
                return pw.Row(
                  children: reporteImagen.map((imagen) {
                    return pw.Expanded(
                      child: pw.Builder(
                        builder: (context) {
                          if(imagen.imagen != "") {
                            var imageBytes = imagesBytes[imagen.idImagen];
                            if (imageBytes != null) {
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
            _formatterNumero(entradaForm.peso),
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
              _validaText(salidaForm.horaInicio),
              _validaText(salidaForm.horaFin)
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
              _formatterNumero(salidaForm.peso),
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
      bool boldUltimo = false,
      double? height,
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
          height: height,
          child: pw.Builder(
            builder: (context) {
              if(celda != '') {
                return pw.Container(
                  child: pw.Text(
                  celda,
                  textAlign: textAlign,
                  style: pw.TextStyle(
                    fontSize: fontSize,
                    fontWeight: boldUltimo && celdas.indexOf(celda) == (celdas.length - 1) ? pw.FontWeight.bold : fontWeight,
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
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 15),
              pw.Image(image,),
            ],
          ),
        ),
        pw.Text(
          "\nTARJA DE SERVICIOS\n\n",
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Row _headerReporteDanios(pw.MemoryImage image, String version) {
    return pw.Row(
      children: [
        pw.Container(
          width: 150,
          child: pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {0: pw.FlexColumnWidth(1)},
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.SizedBox(height: 14),
                        pw.Image(image),
                        pw.SizedBox(height: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {0: pw.FlexColumnWidth(1)},
                children: [
                  _filaTablaEstandar(
                    ['Título del Documento'],
                    fontWeight: pw.FontWeight.bold,
                    color: 0xFFFFFFFF,
                    bgColor: 0xFF1F4E78,
                    fontSize: 10,
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {0: pw.FlexColumnWidth(1)},
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              padding: pw.EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
                              child: pw.Text(
                                'REPORTE DE DAÑOS\nCONTENEDOR',
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColor.fromHex('#797D7F'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.Container(
                    width: 130,
                    child: pw.Row(
                      children: [
                        pw.Container(
                          width: 45,
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {0: pw.FlexColumnWidth(1)},
                            children: [
                              _filaTablaEstandar(
                                ['Fecha:'],
                                textAlign: pw.TextAlign.end,
                                fontWeight: pw.FontWeight.bold,
                                color: 0xFFFFFFFF,
                                bgColor: 0xFF1F4E78,
                                fontSize: 9,
                                padding: pw.EdgeInsets.all(3),
                              ),
                              _filaTablaEstandar(
                                ['Versión:'],
                                textAlign: pw.TextAlign.end,
                                fontWeight: pw.FontWeight.bold,
                                color: 0xFFFFFFFF,
                                bgColor: 0xFF1F4E78,
                                fontSize: 9,
                                padding: pw.EdgeInsets.all(2.5),
                              ),
                              _filaTablaEstandar(
                                ['Clave:'],
                                textAlign: pw.TextAlign.end,
                                fontWeight: pw.FontWeight.bold,
                                color: 0xFFFFFFFF,
                                bgColor: 0xFF1F4E78,
                                fontSize: 9,
                                padding: pw.EdgeInsets.all(2.5),
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {0: pw.FlexColumnWidth(1)},
                            children: [
                              _filaTablaEstandar([
                                fechaReporte,
                              ], padding: pw.EdgeInsets.all(3)),
                              _filaTablaEstandar([
                                version,
                              ], padding: pw.EdgeInsets.all(2.5)),
                              _filaTablaEstandar([
                                _validaText(daniosForm.clave),
                              ], padding: pw.EdgeInsets.all(2.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.TableRow _filaDaniosInfoGeneral(List<String> textos) {
    return pw.TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                textos[0],
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9,
                ),
              ),
              pw.Text(
                textos[1],
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                textos[2],
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9,
                ),
              ),
              pw.Text(
                textos[3],
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.TableRow _filaDaniosTablaInterna({List<pw.Widget> children = const []}) {
    return pw.TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: children,
          ),
        ),
      ],
    );
  }

  pw.TableRow _filaDaniosExterior(List<String> textos) {
    return pw.TableRow(
      children: textos.map((texto) {
        return pw.Container(
          padding: pw.EdgeInsets.all(2),
          child: pw.Text(
            texto,
            textAlign: [0, 2].contains(textos.indexOf(texto))
              ? pw.TextAlign.start
              : pw.TextAlign.center,
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  pw.Container _firmaReporteDanios(Uint8List imageBytes, String pie) {
    return pw.Container(
      width: 160,
      height: 70,
      decoration: pw.BoxDecoration(
        image: pw.DecorationImage(
          image: pw.MemoryImage(imageBytes),
          fit: pw.BoxFit.fitHeight,
        ),
      ),
      child: pw.Column(
        children: [
          pw.Expanded(child: pw.SizedBox()),
          pw.Divider(thickness: 2),
          pw.Text(
            pie,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
          ),
        ],
      ),
    );
  }

  void _crearDatosAdicionalesReporte() {
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
    if(localStorage!.mayusculas!) {
      texto = texto.toUpperCase();
    }
    return texto;
  }

  String _formatterNumero(TextEditingController controller) {
    var texto = controller.text;
    if(texto == "") {
      return "0";
    }
    try {
      var formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
      var numeroFormatter = formatter.format(double.parse(texto));
      var numero = numeroFormatter.replaceAll(",", ".").replaceAll("\$", "");
      numero = numero.substring(0, numero.length - 3);
      return numero;
    } catch(e) {
      return "0";
    }
  }

  bool _esUrl(String? texto) {
    if (texto == null || texto.isEmpty) {
      return false;
    }
    final uri = Uri.tryParse(texto);
    if (uri == null) {
      return false;
    }
    return uri.hasScheme &&
          (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Future<Uint8List?> _obtenerBytesDesdeUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}
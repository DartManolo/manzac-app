import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_view/photo_view.dart';

import '../../data/models/reportes/reporte_imagenes.dart';
import '../../utils/color_list.dart';
import '../../utils/get_injection.dart';
import '../../widgets/buttons/circular_buttons.dart';
import '../../widgets/containers/basic_bottom_sheet_container.dart';
import '../../widgets/forms/mover_fila_form.dart';
import '../../widgets/textformfields/salida_textformfield.dart';

class ReporteEntradaController extends GetInjection {
  SalidaTextformfield salidaTextformfield = SalidaTextformfield();
  int reporteIndex = 0;
  String tipoReporte = "";
  List<String> reporteServicio = [
    "Entrada", "Salida", "Daños"
  ];

  ScrollController galeriaScrollController = ScrollController();
  File? fotografia;
  final ImagePicker seleccionarFoto = ImagePicker();

  List<List<ReporteImagenes>> reporteImagenes = [];

  bool usarGaleria = false;
  int tipoFila = 0;

  @override void onInit() {
    _init();
    super.onInit();
  }

  void _init() {

    try {
    } finally {
      update();
    }
  }
  
  Future<void> tomarFotografia(String idImagen) async {
    try {
      isBusy();
      var fotoCamara = await seleccionarFoto.pickImage(
        source: usarGaleria
          ? ImageSource.gallery
          : ImageSource.camera,
      );
      if (fotoCamara != null) {
        var fotoTemp = File(fotoCamara.path);
        fotografia = await tool.imagenResize(fotoTemp);
        var base64Foto = await tool.imagen2base64(fotografia);
        for (var i = 0; i < reporteImagenes.length; i++) {
          for (var j = 0; j < reporteImagenes[i].length; j++) {
            if(idImagen == reporteImagenes[i][j].idImagen) {
              reporteImagenes[i][j].base64 = base64Foto;
              break;
            }
          }
        }
        update();
      } 
    } finally {
      isBusy(false);
    }
  }

  void agregarFilaImagenes() {
    var limite = tipoFila + 2;
    var fila = reporteImagenes.length;
    var posicion = 2;
    List<ReporteImagenes> filaNueva = [
      ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: 0,
      ),
      ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: 1,
      ),
    ];
    for (var i = 2; i < limite; i++) {
      filaNueva.add(ReporteImagenes(
        idImagen: tool.guid(),
        fila: fila,
        posicion: posicion,
      ));
      posicion++;
    }
    reporteImagenes.add(filaNueva);
    update();
  }

  Future<void> configurarImagen(String idImagen) async {
    ReporteImagenes? imagen;
    int longitud = 0;
    for (var i = 0; i < reporteImagenes.length; i++) {
      for (var j = 0; j < reporteImagenes[i].length; j++) {
        if(reporteImagenes[i][j].idImagen == idImagen) {
          imagen = reporteImagenes[i][j];
          longitud = reporteImagenes[i].length - 1;
          break;
        }
      }
    }
    if(imagen == null) {
      return;
    }
    var imageBytes = base64Decode(imagen.base64!,);
    var context = Get.context;
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.sys[0],
                    color: ColorList.sys[2],
                    icono: MaterialIcons.chevron_left,
                    onPressed: () => _cambiarPosicionImagen(idImagen, longitud),
                  ),
                ),
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.ui[0],
                    color: ColorList.theme[3],
                    icono: MaterialIcons.delete_outline,
                    onPressed: () => _eliminarImagenLista(imagen),
                  ),
                ),
                Expanded(
                  child: CircularButton(
                    size: 40,
                    iconoSize: 20,
                    colorIcono: ColorList.sys[0],
                    color: ColorList.sys[2],
                    icono: MaterialIcons.chevron_right,
                    onPressed: () => _cambiarPosicionImagen(idImagen, longitud, false),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Expanded(
              child: PhotoView(
                imageProvider: MemoryImage(imageBytes),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void configurarFila(int fila) {
    if(reporteImagenes.length == 1) {
      msg("Solo tiene una fila agregada", MsgType.warning);
      return;
    }
    modal(
      widgets: [
        MoverFilaForm(
          filaArriba: () => _cambiarPosicionFila(fila),
          filaAbajo: () => _cambiarPosicionFila(fila, false),
        ),
      ],
    );
  }

  void elimarFilaFotografia(int fila) {
    List<List<ReporteImagenes>> reporteImagenesAux = [];
    for (var i = 0; i < reporteImagenes.length; i++) {
      var numeroFila = reporteImagenes[i][0].fila!;
      if(numeroFila == fila) {
        continue;
      }
      if(numeroFila > fila) {
        var numeroFilaNueva = numeroFila - 1;
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          reporteImagenes[i][j].fila = numeroFilaNueva;
        }
      }
      reporteImagenesAux.add(reporteImagenes[i]);
    }
    reporteImagenes = reporteImagenesAux;
    update();
  }

  void usarGaleriaChanged(bool galeria) {
    usarGaleria = galeria;
    update();
  }

  void tipoFilaChanged(int? fila) {
    tipoFila = fila!;
  }

  void _eliminarImagenLista(ReporteImagenes? imagen) {
    try {
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == imagen!.idImagen) {
            reporteImagenes[i][j].base64 = "";
            break;
          }
        }
      }
    tool.closeBottomSheet();
    update();
    } catch(e) {
      msg("Ocurrió un error al intentar eliminar la imagen", MsgType.error);
    }
  }

  void _cambiarPosicionImagen(String? idImagen, int longitud, [bool atras = true]) {
    try {
      ReporteImagenes? imagen;
      String? idImagenRemplazo = "";
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == idImagen) {
            imagen = reporteImagenes[i][j];
            var posicionRemplazo = reporteImagenes[i][j].posicion!;
            var imagenRemplazo = reporteImagenes[i].where(
              (r) => r.posicion == (atras ? posicionRemplazo - 1 : posicionRemplazo + 1)
            ).firstOrNull;
            if(imagenRemplazo != null) {
              idImagenRemplazo = imagenRemplazo.idImagen;
            }
            break;
          }
        }
      }
      if(imagen == null) {
        toast("Error al posicionar imagen");
        return;
      }
      if((atras && imagen.posicion == 0) || (!atras && (imagen.posicion!) == longitud)) {
        toast("Ya se encuentra al ${(atras ? "inicio" : "final")}");
        return;
      }
      var remplazoPrimario = false;
      var remplazoSecundario = false;
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].idImagen == idImagen) {
            var posicion = reporteImagenes[i][j].posicion!;
            if(atras) {
              reporteImagenes[i][j].posicion = posicion - 1;
            } else {
              reporteImagenes[i][j].posicion = posicion + 1;
            }
            remplazoPrimario = true;
          }
          if(reporteImagenes[i][j].idImagen == idImagenRemplazo) {
            var posicion = reporteImagenes[i][j].posicion!;
            if(atras) {
              reporteImagenes[i][j].posicion = posicion + 1;
            } else {
              reporteImagenes[i][j].posicion = posicion - 1;
            }
            remplazoSecundario = true;
          }
        }
        if(remplazoPrimario && remplazoSecundario) {
          reporteImagenes[i].sort((a, b) => a.posicion!.compareTo(b.posicion!));
        }
      }
      tool.closeBottomSheet();
      update();
    } catch(e) {
      tool.closeBottomSheet();
      msg("Error al configurar la posición de la imagen", MsgType.error);
    } finally {
      update();
    }
  }

  void _cambiarPosicionFila(int fila, [bool arriba = true]) {
    try {
      if((fila == 0 && arriba) || (fila == reporteImagenes.length - 1 && !arriba)) {
        toast("Ya se encuentra al ${(arriba ? "inicio" : "final")}");
        return;
      }
      var filaRemplazo = arriba ? (fila - 1) : (fila + 1);
      for (var i = 0; i < reporteImagenes.length; i++) {
        for (var j = 0; j < reporteImagenes[i].length; j++) {
          if(reporteImagenes[i][j].fila == fila) {
            var filaIndex = reporteImagenes[i][j].fila!;
            if(arriba) {
              reporteImagenes[i][j].fila = filaIndex - 1;
            } else {
              reporteImagenes[i][j].fila = filaIndex + 1;
            }
            continue;
          }
          if(reporteImagenes[i][j].fila == filaRemplazo) {
            var filaIndex = reporteImagenes[i][j].fila!;
            if(arriba) {
              reporteImagenes[i][j].fila = filaIndex + 1;
            } else {
              reporteImagenes[i][j].fila = filaIndex - 1;
            }
            continue;
          }
        }
      }
      List<List<ReporteImagenes>> reporteImagenesAux = [];
      var index = 0;
      while(reporteImagenesAux.length < reporteImagenes.length) {
        for (var i = 0; i < reporteImagenes.length; i++) {
          for (var j = 0; j < reporteImagenes[i].length; j++) {
            var reporteImagenAux = reporteImagenes[i];
            if(reporteImagenAux[j].fila! == index) {
              reporteImagenesAux.add(reporteImagenAux);
              break;
            }
          }
        }
        index++;
      }
      modalClose();
      reporteImagenes = reporteImagenesAux;
      update();
    } catch(e) {
      modalClose();
      msg("Ocurrió un error al intentar cambiar la posición de la fila", MsgType.error);
    } finally {
      update();
    }
  }
}
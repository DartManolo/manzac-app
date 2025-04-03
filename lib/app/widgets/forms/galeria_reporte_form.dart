import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../data/models/reportes/reporte_imagenes.dart';
import '../../utils/color_list.dart';
import '../containers/card_scrollable_container.dart';
import '../defaults/small_header.dart';

class GaleriaReporteForm extends StatelessWidget {
  final ScrollController? scrollController;
  final List<List<ReporteImagenes>> reporteImagenes;
  final bool usarGaleria;
  final void Function(int) elimarFilaFotografia;
  final void Function(String) configurarImagen;
  final void Function(int) configurarFila;
  final void Function(String) tomarFotografia;
  const GaleriaReporteForm({
    super.key,
    this.scrollController,
    this.reporteImagenes = const [],
    this.usarGaleria = false,
    required this.elimarFilaFotografia,
    required this.configurarImagen,
    required this.configurarFila,
    required this.tomarFotografia,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [const SmallHeader(height: 0)];
        },
        body: CustomScrollView(
          controller: scrollController,
          slivers: reporteImagenes.map((reporteImagen) {
            return SliverToBoxAdapter(
              child: Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.50,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      spacing: 1,
                      flex: 1,
                      onPressed: (_) {
                        configurarFila(reporteImagen[0].fila!);
                      },
                      backgroundColor: Color(ColorList.sys[2]),
                      foregroundColor: Color(ColorList.sys[0]),
                      icon: FontAwesome5Solid.expand_arrows_alt,
                      label: 'Mover',
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    SlidableAction(
                      spacing: 1,
                      flex: 1,
                      onPressed: (_) {
                        elimarFilaFotografia(reporteImagen[0].fila!);
                      },
                      backgroundColor: Color(ColorList.theme[3]),
                      foregroundColor: Color(ColorList.ui[0]),
                      icon: MaterialIcons.delete_outline,
                      label: 'Eliminar',
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                      ),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children:
                    reporteImagen.map((imagen) {
                      return Expanded(
                        child: CardScrollableContainer(
                          margin: const EdgeInsets.all(3),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5, ),
                          columnAlign: CrossAxisAlignment.center,
                          mainAlign: MainAxisAlignment.center,
                          height: 130,
                          children: [
                            Builder(
                              builder: (context) {
                                if (imagen.base64 != "") {
                                  var imageBytes = base64Decode(imagen.base64!,);
                                  return InkWell(
                                    onTap: () => configurarImagen(imagen.idImagen!,),
                                    child: Image.memory(
                                      imageBytes,
                                      height: 118,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 40,),
                                    child: InkWell(
                                      onTap: () => tomarFotografia(imagen.idImagen!,),
                                      child: Icon(
                                        usarGaleria
                                          ? MaterialIcons.image_search
                                          : MaterialIcons.camera_alt,
                                        size: 35,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
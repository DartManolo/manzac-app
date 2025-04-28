import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../data/models/reportes/reporte_alta_local.dart';
import '../../utils/color_list.dart';
import '../buttons/circular_buttons.dart';
import '../containers/card_container.dart';
import '../defaults/small_header.dart';

class ReportesServidorForm extends StatelessWidget {
  final ScrollController? scrollController;
  final List<ReporteAltaLocal>? reportesServidor;
  final void Function(ReporteAltaLocal, String) abrirReporte;
  const ReportesServidorForm({
    super.key,
    this.scrollController,
    this.reportesServidor = const [],
    required this.abrirReporte,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [const SmallHeader(height: 0)];
            },
            body: CustomScrollView(
              controller: scrollController,
              slivers: reportesServidor!.map((reporte) {
                var idTarja = "";
                var fecha = "";
                var usuario = "";
                IconData? icono;
                if (reporte.reporteEntrada != null) {
                  idTarja = reporte.reporteEntrada!.idTarja!;
                  fecha = reporte.reporteEntrada!.fecha!;
                  usuario = reporte.reporteEntrada!.nombreUsuario!;
                  icono = MaterialCommunityIcons.truck_delivery_outline;
                } else if (reporte.reporteSalida != null) {
                  idTarja = reporte.reporteSalida!.idTarja!;
                  fecha = reporte.reporteSalida!.fecha!;
                  usuario = reporte.reporteSalida!.nombreUsuario!;
                  icono = MaterialCommunityIcons.truck_flatbed;
                } else if (reporte.reporteDanio != null) {
                  idTarja = reporte.reporteDanio!.idTarja!;
                  fecha = reporte.reporteDanio!.fechaCreado!;
                  usuario = reporte.reporteDanio!.nombreUsuario!;
                  icono = Octicons.container;
                }
                return SliverToBoxAdapter(
                  child: CardContainer(
                    fondo: 0xFFC9CBCD,
                    padding: const EdgeInsets.all(15),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CardContainer(
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      columnAlign: CrossAxisAlignment.center,
                                      width: 50,
                                      radius: 10,
                                      children: [
                                        Icon(
                                          icono,
                                          color: Color(0xFF5D6D7E),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Tipo reporte:  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      reporte.tipo!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Fecha creacion:  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      fecha,
                                      minFontSize: 7,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Creado por:  ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    AutoSizeText(
                                      usuario,
                                      minFontSize: 7,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Color(ColorList.sys[0]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                            child: Column(
                              children: [
                                CircularButton(
                                  color: ColorList.sys[1],
                                  colorIcono: ColorList.sys[3],
                                  icono: FontAwesome5Solid.file_pdf,
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                                  onPressed: () => abrirReporte(reporte, idTarja),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
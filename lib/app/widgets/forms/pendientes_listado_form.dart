import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../data/models/reportes/reporte_alta_local.dart';
import '../../utils/color_list.dart';
import '../buttons/circular_buttons.dart';
import '../containers/card_container.dart';
import '../defaults/small_header.dart';

class PendientesListadoForm extends StatelessWidget {
  final ScrollController? scrollController;
  final List<ReporteAltaLocal>? reportesLocal;
  final void Function(ReporteAltaLocal, [bool]) abrirReporte;
  final void Function(ReporteAltaLocal) subirReportePendiente;
  const PendientesListadoForm({
    super.key,
    this.scrollController,
    this.reportesLocal = const [],
    required this.abrirReporte,
    required this.subirReportePendiente,
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
          slivers: reportesLocal!.map((reporte) {
            var fecha = "";
            IconData? icono;
            if (reporte.reporteEntrada != null) {
              fecha = reporte.reporteEntrada!.fecha!;
              icono = MaterialCommunityIcons.truck_delivery_outline;
            } else if (reporte.reporteSalida != null) {
              fecha = reporte.reporteSalida!.fecha!;
              icono = MaterialCommunityIcons.truck_flatbed;
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
                              onPressed: () => abrirReporte(reporte),
                            ),
                            CircularButton(
                              color: ColorList.sys[0],
                              colorIcono: ColorList.sys[3],
                              icono: Octicons.pencil,
                              margin: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                              onPressed: () => abrirReporte(reporte, false),
                            ),
                            CircularButton(
                              color: ColorList.sys[3],
                              colorIcono: ColorList.sys[0],
                              icono: Octicons.upload,
                              onPressed: () => subirReportePendiente(reporte),
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
    );
  }
}
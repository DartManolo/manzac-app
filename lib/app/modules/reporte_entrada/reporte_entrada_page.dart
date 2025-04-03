import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utils/color_list.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/forms/galeria_reporte_form.dart';
import '../../widgets/forms/sin_galeria_form.dart';
import '../../widgets/switchs/opcion_switch.dart';
import 'reporte_entrada_controller.dart';

class ReporteEntradaPage extends StatelessWidget {
  const ReporteEntradaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReporteEntradaController>(
      builder: (c) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Color(ColorList.sys[0]),
              indicatorColor: Color(ColorList.sys[0]),
              unselectedLabelColor: Color(ColorList.sys[2]),
              tabs: [
                Tab(
                  icon: Icon(Icons.edit_document),
                ),
                Tab(
                  icon: Icon(Icons.image),
                ),
              ],
            ),
            title: Text(""),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [],
              ),
              Column(
                children: [
                  SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        ToggleSwitch(
                          initialLabelIndex: c.tipoFila,
                          minWidth: 80,
                          totalSwitches: 2,
                          labels: ['2 fotos', '3 fotos'],
                          activeBgColor: [Color(ColorList.sys[0])],
                          inactiveBgColor: Color(ColorList.sys[2]),
                          onToggle: c.tipoFilaChanged,
                        ),
                        Expanded(
                          child: SolidButton(
                            texto: 'Agregar',
                            fondoColor: ColorList.sys[1],
                            textoColor: ColorList.sys[3],
                            height: 60,
                            onPressed: () => c.agregarFilaImagenes(),
                            onLongPress: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OpcionSwitch(
                          value: c.usarGaleria,
                          text: "Usar galería",
                          onChanged: c.usarGaleriaChanged,
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if(c.reporteImagenes.isNotEmpty) {
                        return GaleriaReporteForm(
                          scrollController: c.galeriaScrollController,
                          reporteImagenes: c.reporteImagenes,
                          usarGaleria: c.usarGaleria,
                          elimarFilaFotografia: c.elimarFilaFotografia,
                          configurarImagen: c.configurarImagen,
                          configurarFila: c.configurarFila,
                          tomarFotografia: c.tomarFotografia,
                        );
                      } else {
                        return SinGaleriaForm(); 
                      }
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utils/color_list.dart';
import '../../widgets/appbars/menu_appbar.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/forms/danios_reporte.dart';
import '../../widgets/forms/entrada_reporte_form.dart';
import '../../widgets/forms/galeria_reporte_form.dart';
import '../../widgets/forms/salida_reporte_form.dart';
import '../../widgets/forms/sin_galeria_form.dart';
import '../../widgets/switchs/opcion_switch.dart';
import 'reporte_controller.dart';

class ReportePage extends StatelessWidget {
  const ReportePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReporteController>(
      builder: (c) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (pop, result) async {
          if(pop) {
            return;
          }
          await c.cerrar();
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: MenuAppbar(
              texto: "Crear reporte de ${c.tipoReporte}",
              opciones: c.opcionesConsulta,
              cerrar: c.cerrar,
              onTapPopup: c.operacionPopUp,
              onTap: c.seleccionarTap,
              guardarLocal: () => c.soloGuardar(false),
            ),
            body: TabBarView(
              children: [
                Builder(
                  builder: (context) {
                    if(c.tipoReporte == "Entrada") {
                      return EntradaReporteForm(
                        form: c.entradaForm,
                        hourSelected: c.hourSelected,
                        dateSelected: c.dateSelected,
                        abrirComentario: c.abrirComentario,
                        scrollController: c.formScrollController,
                      );
                    } else if(c.tipoReporte == "Salida") {
                      return SalidaReporteForm(
                        form: c.salidaForm,
                        hourSelected: c.hourSelected,
                        dateSelected: c.dateSelected,
                        abrirComentario: c.abrirComentario,
                        scrollController: c.formScrollController,
                      );
                    } else if(c.tipoReporte == "Daños") {
                      return DaniosReporteForm(
                        form: c.daniosForm,
                        dateSelected: c.dateSelected,
                        abrirComentario: c.abrirComentario,
                        onChangedCheck: c.onChangedCheck,
                        seleccionarDanio: c.seleccionarDanio,
                        scrollController: c.formScrollController,
                      );
                    }
                    return SizedBox();
                  }
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
            floatingActionButton: Visibility(
              visible: c.mostrarButtonAyudaDanios,
              child: FloatingActionButton(
                onPressed: c.abrirAyudaDanios,
                shape: const CircleBorder(),
                backgroundColor: Color(ColorList.sys[0]),
                child: Icon(
                  Icons.help,
                  color: Color(ColorList.sys[2]).toMaterialColor(),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          ),
        ),
      ),
    );
  }
}
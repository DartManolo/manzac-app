import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../containers/titulo_container.dart';
import '../defaults/small_header.dart';
import '../switchs/opcion_switch.dart';
import '../textformfields/danios_textformfield.dart';
import '../textforms/date_textform.dart';
import '../textforms/standard_textform.dart';

class DaniosReporteForm extends StatelessWidget {
  final DaniosTextformfield form;
  final void Function() dateSelected;
  final void Function() abrirComentario;
  final void Function() onChangedCheck;
  final void Function(TextEditingController, String) seleccionarDanio;
  final ScrollController? scrollController;
  const DaniosReporteForm({
    super.key,
    required this.form,
    required this.dateSelected,
    required this.abrirComentario,
    required this.onChangedCheck,
    required this.seleccionarDanio,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [const SmallHeader(height: 0)];
      },
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: StandardTextform(
                    icon: Octicons.versions,
                    text: 'Version',
                    controller: form.version,
                    focusNode: form.versionFocus,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: StandardTextform(
                    text: 'Clave',
                    controller: form.clave,
                    focusNode: form.claveFocus,
                    icon: Octicons.key,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: DateTextform(
                    text: 'Fecha',
                    controller: form.fechaReporte,
                    focusNode: form.fechaReporteFocus,
                    dateSelected: dateSelected,
                    icon: FontAwesome.calendar_times_o,
                    formato: 'dd-MM-yyyy',
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome5Solid.ship,
              text: 'Línea naviera',
              controller: form.lineaNaviera,
              focusNode: form.lineaNavieraFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.person_pin_outlined,
              text: 'Cliente',
              controller: form.cliente,
              focusNode: form.clienteFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Número de contenedor',
              controller: form.numContenedor,
              focusNode: form.numContenedorFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.vacio,
                    text: "Vacío",
                    onChanged: (c) {
                      form.vacio = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(
                  child: OpcionSwitch(
                    value: form.lleno,
                    text: "Lleno",
                    onChanged: (c) {
                      form.lleno = c;
                      onChangedCheck();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.d20,
                    text: "20'",
                    onChanged: (c) {
                      form.d20 = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(
                  child: OpcionSwitch(
                    value: form.d40,
                    text: "40'",
                    onChanged: (c) {
                      form.d40 = c;
                      onChangedCheck();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.hc,
                    text: "HC",
                    onChanged: (c) {
                      form.hc = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(
                  child: OpcionSwitch(
                    value: form.otro,
                    text: "Otro",
                    onChanged: (c) {
                      form.otro = c;
                      onChangedCheck();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.estandar,
                    text: "Estándar",
                    onChanged: (c) {
                      form.estandar = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(
                  child: OpcionSwitch(
                    value: form.opentop,
                    text: "Open Top",
                    onChanged: (c) {
                      form.opentop = c;
                      onChangedCheck();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.flatRack,
                    text: "Flat Rack",
                    onChanged: (c) {
                      form.flatRack = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(
                  child: OpcionSwitch(
                    value: form.reefer,
                    text: "Reefer",
                    onChanged: (c) {
                      form.reefer = c;
                      onChangedCheck();
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(width: 15,),
                Expanded(
                  child: OpcionSwitch(
                    value: form.reforzado,
                    text: "Reforzado",
                    onChanged: (c) {
                      form.reforzado = c;
                      onChangedCheck();
                    },
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.tag,
              text: 'Sello  N°',
              controller: form.numSello,
              focusNode: form.numSelloFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: TituloContainer(
              texto: 'Interior',
              size: 16,
              ltrbp: const [20, 0, 10, 10],
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Izquierda)',
              controller: form.intPuertasIzq,
              focusNode: form.intPuertasIzqFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPuertasIzq,
                'Int: Puertas (Izquierda)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Derecha)',
              controller: form.intPuertasDer,
              focusNode: form.intPuertasDerFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPuertasDer,
                'Int: Puertas (Derecha)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.floor_plan,
              text: 'Piso',
              controller: form.intPiso,
              focusNode: form.intPisoFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPiso,
                'Int: Piso'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.home_roof,
              text: 'Techo',
              controller: form.intTecho,
              focusNode: form.intTechoFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intTecho,
                'Int: Techo'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Lateral (Izquierda)',
              controller: form.intPanelLateralIzq,
              focusNode: form.intPanelLateralIzqFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPanelLateralIzq,
                'Int: Panel Lateral (Izquierda)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Lateral (Derecha)',
              controller: form.intPanelLateralDer,
              focusNode: form.intPanelLateralDerFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPanelLateralDer,
                'Int: Panel Lateral (Derecha)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Fondo',
              controller: form.intPanelFondo,
              focusNode: form.intPanelFondoFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.intPanelFondo,
                'Int: Panel Fondo'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TituloContainer(
              texto: 'Exterior',
              size: 16,
              ltrbp: const [20, 0, 10, 10],
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Izquierda)',
              controller: form.extPuertasIzq,
              focusNode: form.extPuertasIzqFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPuertasIzq,
                'Ext: Puertas (Izquierda)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Derecha)',
              controller: form.extPuertasDer,
              focusNode: form.extPuertasDerFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPuertasDer,
                'Ext: Puertas (Derecha)'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Ionicons.pin_outline,
              text: 'Poste',
              controller: form.extPoste,
              focusNode: form.extPosteFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPoste,
                'Ext: Poste'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Foundation.social_steam,
              text: 'Palanca',
              controller: form.extPalanca,
              focusNode: form.extPalancaFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPalanca,
                'Ext: Palanca'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.hook,
              text: 'Gancho de cierre',
              controller: form.extGanchoCierre,
              focusNode: form.extGanchoCierreFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extGanchoCierre,
                'Ext: Gancho de cierre'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Izquierdo',
              controller: form.extPanelIzq,
              focusNode: form.extPanelIzqFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPanelIzq,
                'Ext: Panel Izquierdo'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Derecho',
              controller: form.extPanelDer,
              focusNode: form.extPanelDerFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPanelDer,
                'Ext: Panel Derecho'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Fondo',
              controller: form.extPanelFondo,
              focusNode: form.extPanelFondoFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extPanelFondo,
                'Ext: Panel Fondo'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.ruler_square,
              text: 'Cantonera',
              controller: form.extCantonera,
              focusNode: form.extCantoneraFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extCantonera,
                'Ext: Cantonera'
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Frisa',
              controller: form.extFrisa,
              focusNode: form.extFrisaFocus,
              readOnly: true,
              onTap: () => seleccionarDanio(
                form.extFrisa,
                'Ext: Frisa'
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SolidButton(
              fondoColor: ColorList.sys[1],
              texto: 'Agregar Observaciones',
              icono: Icons.comment,
              textoColor: ColorList.sys[3],
              onPressed: abrirComentario,
              onLongPress: () { },
            ),
          ),
          SmallHeader(height: 20),
        ],
      ),
    );
  }
}
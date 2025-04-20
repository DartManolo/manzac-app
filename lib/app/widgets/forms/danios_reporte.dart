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
  final ScrollController? scrollController;
  const DaniosReporteForm({
    super.key,
    required this.form,
    required this.dateSelected,
    required this.abrirComentario,
    required this.onChangedCheck,
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
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Derecha)',
              controller: form.intPuertasDer,
              focusNode: form.intPuertasDerFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.floor_plan,
              text: 'Piso',
              controller: form.intPiso,
              focusNode: form.intPisoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.home_roof,
              text: 'Techo',
              controller: form.intTecho,
              focusNode: form.intTechoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Lateral (Izquierda)',
              controller: form.intPanelLateralIzq,
              focusNode: form.intPanelLateralIzqFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Lateral (Derecha)',
              controller: form.intPanelLateralDer,
              focusNode: form.intPanelLateralDerFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Fondo',
              controller: form.intPanelFondo,
              focusNode: form.intPanelFondoFocus,
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
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.door_sliding_outlined,
              text: 'Puertas (Derecha)',
              controller: form.extPuertasDer,
              focusNode: form.extPuertasDerFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Ionicons.pin_outline,
              text: 'Poste',
              controller: form.extPoste,
              focusNode: form.extPosteFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Foundation.social_steam,
              text: 'Palanca',
              controller: form.extPalanca,
              focusNode: form.extPalancaFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.hook,
              text: 'Gancho de cierre',
              controller: form.extGanchoCierre,
              focusNode: form.extGanchoCierreFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Izquierdo',
              controller: form.extPanelIzq,
              focusNode: form.extPanelIzqFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Derecho',
              controller: form.extPanelDer,
              focusNode: form.extPanelDerFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Panel Fondo',
              controller: form.extPanelFondo,
              focusNode: form.extPanelFondoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.ruler_square,
              text: 'Cantonera',
              controller: form.extCantonera,
              focusNode: form.extCantoneraFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Frisa',
              controller: form.extFrisa,
              focusNode: form.extFrisaFocus,
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
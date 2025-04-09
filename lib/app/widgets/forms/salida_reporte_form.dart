import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../defaults/small_header.dart';
import '../textformfields/salida_textformfield.dart';
import '../textforms/hour_textform.dart';
import '../textforms/standard_textform.dart';

class SalidaReporteForm extends StatelessWidget {
  final SalidaTextformfield form;
  final void Function() hourSelected;
  final void Function() dateSelected;
  final void Function() abrirComentario;
  final ScrollController? scrollController;
  const SalidaReporteForm({
    super.key,
    required this.form,
    required this.hourSelected,
    required this.dateSelected,
    required this.abrirComentario,
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
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Referencia LM',
              controller: form.referenciaLm,
              focusNode: form.referenciaLmFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.warning_amber_rounded,
              text: 'IMO',
              controller: form.imo,
              focusNode: form.imoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: HourTextform(
                    controller: form.horaInicio,
                    focusNode: form.horaInicioFocus,
                    text: 'Hora inicio',
                    hourSelected: hourSelected,
                  ),
                ),
                Expanded(
                  child: HourTextform(
                    controller: form.horaFin,
                    focusNode: form.horaFinFocus,
                    text: 'Hora de fin',
                    hourSelected: hourSelected,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.person,
              text: 'Cliente',
              controller: form.cliente,
              focusNode: form.clienteFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome5Solid.box_open,
              text: 'Mercancía',
              controller: form.mercancia,
              focusNode: form.mercanciaFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome5Regular.user_circle,
              text: 'Agente aduanal',
              controller: form.agenteAduanal,
              focusNode: form.agenteAduanalFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.tie,
              text: 'Ejecutivo',
              controller: form.ejecutivo,
              focusNode: form.ejecutivoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.container,
              text: 'Contenedor y/o BL',
              controller: form.contenedor,
              focusNode: form.contenedorFocus,
            ),
          ),    
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.book,
              text: 'Pedimento / Booking',
              controller: form.pedimento,
              focusNode: form.pedimentoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: MaterialCommunityIcons.lock,
              text: 'Sello',
              controller: form.sello,
              focusNode: form.selloFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome5Solid.ship,
              text: 'Buque',
              controller: form.buque,
              focusNode: form.buqueFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Octicons.person_fill,
              text: 'Referencia cliente',
              controller: form.refCliente,
              focusNode: form.refClienteFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Feather.box,
              text: 'Bultos',
              controller: form.bultos,
              focusNode: form.bultosFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.monitor_weight_outlined,
              text: 'Peso',
              controller: form.peso,
              focusNode: form.pesoFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome.ship,
              text: 'Terminal',
              controller: form.terminal,
              focusNode: form.terminalFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome.truck,
              text: 'Transporte',
              controller: form.transporte,
              focusNode: form.transporteFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome.drivers_license,
              text: 'Operador',
              controller: form.operador,
              focusNode: form.operadorFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: Icons.drive_eta,
              text: 'Placas',
              controller: form.placas,
              focusNode: form.placasFocus,
            ),
          ),
          SliverToBoxAdapter(
            child: StandardTextform(
              icon: FontAwesome.id_card_o,
              text: 'Licencia',
              controller: form.licencia,
              focusNode: form.licenciaFocus,
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
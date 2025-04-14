import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../defaults/small_header.dart';
import '../textformfields/entrada_textformfield.dart';
import '../textforms/date_textform.dart';
import '../textforms/hour_textform.dart';
import '../textforms/standard_textform.dart';

class EntradaReporteForm extends StatelessWidget {
  final EntradaTextformfield form;
  final void Function() hourSelected;
  final void Function() dateSelected;
  final void Function() abrirComentario;
  final ScrollController? scrollController;
  const EntradaReporteForm({
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
              keyboardType: TextInputType.number,
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
            child: Row(
              children: [
                Expanded(
                  child: DateTextform(
                    text: 'Fecha Despacho',
                    controller: form.fechaDespacho,
                    focusNode: form.fechaDespachoFocus,
                    dateSelected: dateSelected,
                    icon: FontAwesome.calendar_o,
                    formato: 'dd/MM/yyyy',
                  ),
                ),
                Expanded(
                  child: StandardTextform(
                    icon: FontAwesome.calendar_check_o,
                    text: 'Dias libres',
                    controller: form.diasLibres,
                    focusNode: form.diasLibresFocus,
                    keyboardType: TextInputType.number,
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
                    text: 'Fecha vencimiento',
                    controller: form.fechaVencimiento,
                    focusNode: form.fechaVencimientoFocus,
                    dateSelected: dateSelected,
                    icon: FontAwesome.calendar_times_o,
                    formato: 'dd/MM/yyyy',
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
              icon: FontAwesome.arrows,
              text: 'Movimiento',
              controller: form.movimiento,
              focusNode: form.movimientoFocus,
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
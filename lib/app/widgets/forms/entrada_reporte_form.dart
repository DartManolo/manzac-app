import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/circular_buttons.dart';
import '../textformfields/entrada_textformfield.dart';
import '../textforms/hour_textform.dart';

class EntradaReporteForm extends StatelessWidget {
  final EntradaTextformfield form;
  final void Function() hourSelected;
  const EntradaReporteForm({
    super.key,
    required this.form,
    required this.hourSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: HourTextform(
                controller: form.horaInicio,
                text: 'Hora inicio',
                hourSelected: hourSelected,
              ),
            ),
            Expanded(
              child: HourTextform(
                controller: form.horaFin,
                text: 'Hora de fin',
                hourSelected: hourSelected,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
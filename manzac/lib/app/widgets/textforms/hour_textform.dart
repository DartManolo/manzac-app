import 'package:flutter/material.dart';

import '../../utils/color_list.dart';

class HourTextform extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function() hourSelected;
  final List<double> ltrbp;
  final bool readOnly;
  final bool clean;
  final String text;
  final IconData icon;
  final bool canTap;
  final double? height;

  const HourTextform({
    super.key,
    this.controller,
    this.focusNode,
    this.ltrbp = const [10, 10, 10, 10,],
    this.readOnly = true,
    this.clean = false,
    this.text = "Hora",
    this.icon = Icons.watch_later_outlined,
    required this.hourSelected,
    this.canTap = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.fromLTRB(
        ltrbp[0],
        ltrbp[1],
        ltrbp[2],
        ltrbp[3],
      ),
      child: TextFormField(
        onTap: () {
          if(clean) {
            controller!.text = "";
          }
          if(!canTap) {
            return;
          }
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dialOnly,
            cancelText: "Cancelar",
            confirmText: "Aceptar",
          ).then((selectedHour) {
            selectedHour ??= TimeOfDay.now();
            var horaAux = selectedHour.hour;
            var prefijo = "a.m.";
            var hora = horaAux;
            if(horaAux == 0) {
              hora = 12;
            } else if(horaAux > 12) {
              hora = horaAux - 12;
              prefijo = "p.m.";
            }
            if(horaAux == 12) {
              prefijo = "p.m.";
            }
            var minutos = selectedHour.minute;
            controller!.text = "${(hora > 9 ? "$hora" : "0$hora")}:${(minutos > 9 ? "$minutos" : "0$minutos")} $prefijo";
            hourSelected();
          });
        },
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: text,
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: Icon(
            icon,
            color: Color(ColorList.sys[0]),
          ),
          hintText: text,
        ),
      ),
    );
  }
}
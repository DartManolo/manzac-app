import 'package:flutter/widgets.dart';

class MenuOpciones {
  String titulo;
  String ruta;
  IconData? icono;
  void Function() accion;
  bool selected;

  MenuOpciones({
    this.titulo = "",
    this.ruta = "",
    this.icono,
    required this.accion,
    this.selected = false,
  });
}
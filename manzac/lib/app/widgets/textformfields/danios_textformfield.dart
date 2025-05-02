import 'package:flutter/material.dart';

class DaniosTextformfield {
  TextEditingController version = TextEditingController();
  FocusNode versionFocus = FocusNode();
  TextEditingController clave = TextEditingController();
  FocusNode claveFocus = FocusNode();

  TextEditingController fechaReporte = TextEditingController();
  FocusNode fechaReporteFocus = FocusNode();
  TextEditingController lineaNaviera = TextEditingController();
  FocusNode lineaNavieraFocus = FocusNode();
  TextEditingController cliente = TextEditingController();
  FocusNode clienteFocus = FocusNode();
  TextEditingController numContenedor = TextEditingController();
  FocusNode numContenedorFocus = FocusNode();

  bool vacio = false;
  bool lleno = false;
  bool d20 = false;
  bool d40 = false;
  bool hc = false;
  bool otro = false;
  bool estandar = false;
  bool opentop = false;
  bool flatRack = false;
  bool reefer = false;
  bool reforzado = false;
  TextEditingController numSello = TextEditingController();
  FocusNode numSelloFocus = FocusNode();

  TextEditingController intPuertasIzq = TextEditingController();
  FocusNode intPuertasIzqFocus = FocusNode();
  TextEditingController intPuertasDer = TextEditingController();
  FocusNode intPuertasDerFocus = FocusNode();
  TextEditingController intPiso = TextEditingController();
  FocusNode intPisoFocus = FocusNode();
  TextEditingController intTecho = TextEditingController();
  FocusNode intTechoFocus = FocusNode();
  TextEditingController intPanelLateralIzq = TextEditingController();
  FocusNode intPanelLateralIzqFocus = FocusNode();
  TextEditingController intPanelLateralDer = TextEditingController();
  FocusNode intPanelLateralDerFocus = FocusNode();
  TextEditingController intPanelFondo = TextEditingController();
  FocusNode intPanelFondoFocus = FocusNode();

  TextEditingController extPuertasIzq = TextEditingController();
  FocusNode extPuertasIzqFocus = FocusNode();
  TextEditingController extPuertasDer = TextEditingController();
  FocusNode extPuertasDerFocus = FocusNode();
  TextEditingController extPoste = TextEditingController();
  FocusNode extPosteFocus = FocusNode();
  TextEditingController extPalanca = TextEditingController();
  FocusNode extPalancaFocus = FocusNode();
  TextEditingController extGanchoCierre = TextEditingController();
  FocusNode extGanchoCierreFocus = FocusNode();
  TextEditingController extPanelIzq = TextEditingController();
  FocusNode extPanelIzqFocus = FocusNode();
  TextEditingController extPanelDer = TextEditingController();
  FocusNode extPanelDerFocus = FocusNode();
  TextEditingController extPanelFondo = TextEditingController();
  FocusNode extPanelFondoFocus = FocusNode();
  TextEditingController extCantonera = TextEditingController();
  FocusNode extCantoneraFocus = FocusNode();
  TextEditingController extFrisa = TextEditingController();
  FocusNode extFrisaFocus = FocusNode();

  TextEditingController observaciones = TextEditingController();
  FocusNode observacionesFocus = FocusNode();
}
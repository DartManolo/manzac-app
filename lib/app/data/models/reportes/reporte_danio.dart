import 'reporte_imagenes.dart';

class ReporteDanio {
  String? idTarja;
  String? tipo;
  String? fecha;
  String? fechaCreado;
  String? version;
  String? clave;
  String? fechaReporte;
  String? lineaNaviera;
  String? cliente;
  String? numContenedor;
  String? vacio;
  String? lleno;
  String? d20;
  String? d40;
  String? hc;
  String? otro;
  String? estandar;
  String? opentop;
  String? flatRack;
  String? reefer;
  String? reforzado;
  String? numSello;
  String? intPuertasIzq;
  String? intPuertasDer;
  String? intPiso;
  String? intTecho;
  String? intPanelLateralIzq;
  String? intPanelLateralDer;
  String? intPanelFondo;
  String? extPuertasIzq;
  String? extPuertasDer;
  String? extPoste;
  String? extPalanca;
  String? extGanchoCierre;
  String? extPanelIzq;
  String? extPanelDer;
  String? extPanelFondo;
  String? extCantonera;
  String? extFrisa;
  String? observaciones;
  String? usuario;
  List<ReporteImagenes>? imagenes;

  ReporteDanio({
    this.idTarja = "",
    this.tipo = "DAÑOS",
    this.fecha = "",
    this.fechaCreado = "",
    this.version = "",
    this.clave = "",
    this.fechaReporte = "",
    this.lineaNaviera = "",
    this.cliente = "",
    this.numContenedor = "",
    this.vacio = "",
    this.lleno = "",
    this.d20 = "",
    this.d40 = "",
    this.hc = "",
    this.otro = "",
    this.estandar = "",
    this.opentop = "",
    this.flatRack = "",
    this.reefer = "",
    this.reforzado = "",
    this.numSello = "",
    this.intPuertasIzq = "",
    this.intPuertasDer = "",
    this.intPiso = "",
    this.intTecho = "",
    this.intPanelLateralIzq = "",
    this.intPanelLateralDer = "",
    this.intPanelFondo = "",
    this.extPuertasIzq = "",
    this.extPuertasDer = "",
    this.extPoste = "",
    this.extPalanca = "",
    this.extGanchoCierre = "",
    this.extPanelIzq = "",
    this.extPanelDer = "",
    this.extPanelFondo = "",
    this.extCantonera = "",
    this.extFrisa = "",
    this.observaciones = "",
    this.usuario = "",
    this.imagenes = const [],
  });

  Map toJson () => {
    'idTarja' : idTarja,
    'tipo' : tipo,
    'fecha' : fecha,
    'fechaCreado' : fechaCreado,
    'version' : version,
    'clave' :   clave,
    'fechaReporte' :   fechaReporte,
    'lineaNaviera' :   lineaNaviera,
    'cliente' :   cliente,
    'numContenedor' :   numContenedor,
    'vacio' :   vacio,
    'lleno' :   lleno,
    'd20' :   d20,
    'd40' :   d40,
    'hc' :   hc,
    'otro' :   otro,
    'estandar' :   estandar,
    'opentop' :   opentop,
    'flatRack' :   flatRack,
    'reefer' :   reefer,
    'reforzado' :   reforzado,
    'numSello' :   numSello,
    'intPuertasIzq' :   intPuertasIzq,
    'intPuertasDer' :   intPuertasDer,
    'intPiso' :   intPiso,
    'intTecho' :   intTecho,
    'intPanelLateralIzq' :   intPanelLateralIzq,
    'intPanelLateralDer' :   intPanelLateralDer,
    'intPanelFondo' :   intPanelFondo,
    'extPuertasIzq' :   extPuertasIzq,
    'extPuertasDer' :   extPuertasDer,
    'extPoste' :   extPoste,
    'extPalanca' :   extPalanca,
    'extGanchoCierre' :   extGanchoCierre,
    'extPanelIzq' :   extPanelIzq,
    'extPanelDer' :   extPanelDer,
    'extPanelFondo' :   extPanelFondo,
    'extCantonera' :   extCantonera,
    'extFrisa' :   extFrisa,
    'observaciones' :   observaciones,
    'usuario' :   usuario,
    'imagenes' : imagenes,
  };

  ReporteDanio.fromMap(Map<String, dynamic> json) {
    idTarja = json['idTarja'] ?? "";
    tipo = json['tipo'] ?? "";
    fecha = json['fecha'] ?? "";
    fechaCreado = json['fechaCreado'] ?? "";
    version = json['version'] ?? "";
    clave = json['clave'] ?? "";
    fechaReporte = json['fechaReporte'] ?? "";
    lineaNaviera = json['lineaNaviera'] ?? "";
    cliente = json['cliente'] ?? "";
    numContenedor = json['numContenedor'] ?? "";
    vacio = json['vacio'] ?? "";
    lleno = json['lleno'] ?? "";
    d20 = json['d20'] ?? "";
    d40 = json['d40'] ?? "";
    hc = json['hc'] ?? "";
    otro = json['otro'] ?? "";
    estandar = json['estandar'] ?? "";
    opentop = json['opentop'] ?? "";
    flatRack = json['flatRack'] ?? "";
    reefer = json['reefer'] ?? "";
    reforzado = json['reforzado'] ?? "";
    numSello = json['numSello'] ?? "";
    intPuertasIzq = json['intPuertasIzq'] ?? "";
    intPuertasDer = json['intPuertasDer'] ?? "";
    intPiso = json['intPiso'] ?? "";
    intTecho = json['intTecho'] ?? "";
    intPanelLateralIzq = json['intPanelLateralIzq'] ?? "";
    intPanelLateralDer = json['intPanelLateralDer'] ?? "";
    intPanelFondo = json['intPanelFondo'] ?? "";
    extPuertasIzq = json['extPuertasIzq'] ?? "";
    extPuertasDer = json['extPuertasDer'] ?? "";
    extPoste = json['extPoste'] ?? "";
    extPalanca = json['extPalanca'] ?? "";
    extGanchoCierre = json['extGanchoCierre'] ?? "";
    extPanelIzq = json['extPanelIzq'] ?? "";
    extPanelDer = json['extPanelDer'] ?? "";
    extPanelFondo = json['extPanelFondo'] ?? "";
    extCantonera = json['extCantonera'] ?? "";
    extFrisa = json['extFrisa'] ?? "";
    observaciones = json['observaciones'] ?? "";
    usuario = json['usuario'] ?? "";
    imagenes = ReporteImagenes().fromArray(json['imagenes']);
  }
}
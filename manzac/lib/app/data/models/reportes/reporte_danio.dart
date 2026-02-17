import 'package:hive_ce/hive.dart';

import '../hive_model.dart';
import 'reporte_imagenes.dart';

part 'reporte_danio.g.dart';

@HiveType(typeId: 4)
class ReporteDanio extends HiveModel {
  static const String boxName = "reporte_danio";

  @HiveField(0)
  @override
  String? id;

  @HiveField(1)
  String? idTarja;

  @HiveField(2)
  String? tipo;

  @HiveField(3)
  String? fecha;

  @HiveField(4)
  String? fechaCreado;

  @HiveField(5)
  String? version;

  @HiveField(6)
  String? clave;

  @HiveField(7)
  String? fechaReporte;

  @HiveField(8)
  String? lineaNaviera;

  @HiveField(9)
  String? cliente;

  @HiveField(10)
  String? numContenedor;

  @HiveField(11)
  String? vacio;

  @HiveField(12)
  String? lleno;

  @HiveField(13)
  String? d20;

  @HiveField(14)
  String? d40;
  
  @HiveField(15)
  String? hc;
  
  @HiveField(16)
  String? otro;
  
  @HiveField(17)
  String? estandar;
  
  @HiveField(18)
  String? opentop;
  
  @HiveField(19)
  String? flatRack;
  
  @HiveField(20)
  String? reefer;
  
  @HiveField(21)
  String? reforzado;
  
  @HiveField(22)
  String? numSello;
  
  @HiveField(23)
  String? intPuertasIzq;
  
  @HiveField(24)
  String? intPuertasDer;
  
  @HiveField(25)
  String? intPiso;
  
  @HiveField(26)
  String? intTecho;
  
  @HiveField(27)
  String? intPanelLateralIzq;
  
  @HiveField(28)
  String? intPanelLateralDer;
  
  @HiveField(29)
  String? intPanelFondo;
  
  @HiveField(30)
  String? extPuertasIzq;
  
  @HiveField(31)
  String? extPuertasDer;
  
  @HiveField(32)
  String? extPoste;
  
  @HiveField(33)
  String? extPalanca;
  
  @HiveField(34)
  String? extGanchoCierre;
  
  @HiveField(35)
  String? extPanelIzq;
  
  @HiveField(36)
  String? extPanelDer;
  
  @HiveField(37)
  String? extPanelFondo;
  
  @HiveField(38)
  String? extCantonera;
  
  @HiveField(39)
  String? extFrisa;
  
  @HiveField(40)
  String? observaciones;
  
  @HiveField(41)
  String? usuario;

  @HiveField(42)
  List<ReporteImagenes>? imagenes;
  
  @HiveField(43)
  String? nombreUsuario;
  
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
    this.nombreUsuario = "",
  });

  Map<String, dynamic> toJson () => {
    'id'      : id,
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
    'imagenes' : imagenes?.map((img) => img.toJson()).toList(),
    'nombreUsuario' :   nombreUsuario,
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
    nombreUsuario = json['nombreUsuario'] ?? "";
  }
}
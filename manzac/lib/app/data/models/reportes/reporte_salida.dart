import 'package:hive_ce_flutter/adapters.dart';

import '../hive_model.dart';
import 'reporte_imagenes.dart';

part 'reporte_salida.g.dart';

@HiveType(typeId: 3)
class ReporteSalida extends HiveModel {
  static const String boxName = "reporte_salida";

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
  String? referenciaLm;

  @HiveField(5)
  String? imo;

  @HiveField(6)
  String? horaInicio;

  @HiveField(7)
  String? horaFin;

  @HiveField(8)
  String? cliente;

  @HiveField(9)
  String? mercancia;

  @HiveField(10)
  String? agenteAduanal;

  @HiveField(11)
  String? ejecutivo;

  @HiveField(12)
  String? contenedor;

  @HiveField(13)
  String? pedimento;

  @HiveField(14)
  String? sello;

  @HiveField(15)
  String? buque;

  @HiveField(16)
  String? refCliente;

  @HiveField(17)
  String? bultos;

  @HiveField(18)
  String? peso;

  @HiveField(19)
  String? terminal;

  @HiveField(20)
  String? transporte;

  @HiveField(21)
  String? operador;

  @HiveField(22)
  String? placas;

  @HiveField(23)
  String? licencia;

  @HiveField(24)
  String? observaciones;

  @HiveField(25)
  String? usuario;

  @HiveField(26)
  List<ReporteImagenes>? imagenes;

  @HiveField(27)
  String? nombreUsuario;

  ReporteSalida({
    this.idTarja = "",
    this.tipo = "ENTRADA",
    this.fecha = "",
    this.referenciaLm = "\n",
    this.imo = "\n",
    this.horaInicio = "\n",
    this.horaFin = "\n",
    this.cliente = "\n",
    this.mercancia = "\n",
    this.agenteAduanal = "\n",
    this.ejecutivo = "\n",
    this.contenedor = "\n",
    this.pedimento = "\n",
    this.sello = "\n",
    this.buque = "\n",
    this.refCliente = "\n",
    this.bultos = "\n",
    this.peso = "\n",
    this.terminal = "\n",
    this.transporte = "\n",
    this.operador = "\n",
    this.placas = "\n",
    this.licencia = "\n",
    this.observaciones = "\n",
    this.usuario = "",
    this.imagenes = const [],
    this.nombreUsuario = "",
  });

  Map<String, dynamic> toJson() => {
    'id' : id,
    'idTarja' : idTarja,
    'tipo' : tipo,
    'fecha' : fecha,
    'referenciaLm' : referenciaLm,
    'imo' : imo,
    'horaInicio' : horaInicio,
    'horaFin' : horaFin,
    'cliente' : cliente,
    'mercancia' : mercancia,
    'agenteAduanal' : agenteAduanal,
    'ejecutivo' : ejecutivo,
    'contenedor' : contenedor,
    'pedimento' : pedimento,
    'sello' : sello,
    'buque' : buque,
    'refCliente' : refCliente,
    'bultos' : bultos,
    'peso' : peso,
    'terminal' : terminal,
    'transporte' : transporte,
    'operador' : operador,
    'placas' : placas,
    'licencia' : licencia,
    'observaciones' : observaciones,
    'usuario' :   usuario,
    'imagenes' : imagenes?.map((img) => img.toJson()).toList(),
    'nombreUsuario' :   nombreUsuario,
  };

  ReporteSalida.fromMap(Map<String, dynamic> json) {
    idTarja = json['idTarja'] ?? "";
    tipo = json['tipo'] ?? "";
    fecha = json['fecha'] ?? "";
    referenciaLm = json['referenciaLm'] ?? "";
    imo = json['imo'] ?? "";
    horaInicio = json['horaInicio'] ?? "";
    horaFin = json['horaFin'] ?? "";
    cliente = json['cliente'] ?? "";
    mercancia = json['mercancia'] ?? "";
    agenteAduanal = json['agenteAduanal'] ?? "";
    ejecutivo = json['ejecutivo'] ?? "";
    contenedor = json['contenedor'] ?? "";
    pedimento = json['pedimento'] ?? "";
    sello = json['sello'] ?? "";
    buque = json['buque'] ?? "";
    refCliente = json['refCliente'] ?? "";
    bultos = json['bultos'] ?? "";
    peso = json['peso'] ?? "";
    terminal = json['terminal'] ?? "";
    transporte = json['transporte'] ?? "";
    operador = json['operador'] ?? "";
    placas = json['placas'] ?? "";
    licencia = json['licencia'] ?? "";
    observaciones = json['observaciones'] ?? "";
    usuario = json['usuario'] ?? "";
    imagenes = ReporteImagenes().fromArray(json['imagenes']);
    nombreUsuario = json['nombreUsuario'] ?? "";
  }
}
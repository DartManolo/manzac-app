import 'package:hive_ce_flutter/adapters.dart';

import '../hive_model.dart';
import 'reporte_imagenes.dart';

part 'reporte_entrada.g.dart';

@HiveType(typeId: 2)
class ReporteEntrada extends HiveModel {
  static const String boxName = "reporte_entrada";

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
  String? fechaDespacho;

  @HiveField(21)
  String? diasLibres;

  @HiveField(22)
  String? fechaVencimiento;

  @HiveField(23)
  String? movimiento;

  @HiveField(25)
  String? observaciones;

  @HiveField(26)
  String? usuario;

  @HiveField(27)
  List<ReporteImagenes>? imagenes;

  @HiveField(28)
  String? nombreUsuario;

  ReporteEntrada({
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
    this.fechaDespacho = "\n",
    this.diasLibres = "\n",
    this.fechaVencimiento = "\n",
    this.movimiento = "\n",
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
    'fechaDespacho' : fechaDespacho,
    'diasLibres' : diasLibres,
    'fechaVencimiento' : fechaVencimiento,
    'movimiento' : movimiento,
    'observaciones' : observaciones,
    'usuario' :   usuario,
    'imagenes' : imagenes?.map((img) => img.toJson()).toList(),
    'nombreUsuario' :   nombreUsuario,
  };

  ReporteEntrada.fromMap(Map<String, dynamic> json) {
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
    fechaDespacho = json['fechaDespacho'] ?? "";
    diasLibres = json['diasLibres'] ?? "";
    fechaVencimiento = json['fechaVencimiento'] ?? "";
    movimiento = json['movimiento'] ?? "";
    observaciones = json['observaciones'] ?? "";
    usuario = json['usuario'] ?? "";
    imagenes = ReporteImagenes().fromArray(json['imagenes']);
    nombreUsuario = json['nombreUsuario'] ?? "";
  }
}
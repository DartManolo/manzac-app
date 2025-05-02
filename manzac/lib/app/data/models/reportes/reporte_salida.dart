import 'reporte_imagenes.dart';

class ReporteSalida {
  String? idTarja;
  String? tipo;
  String? fecha;
  String? referenciaLm;
  String? imo;
  String? horaInicio;
  String? horaFin;
  String? cliente;
  String? mercancia;
  String? agenteAduanal;
  String? ejecutivo;
  String? contenedor;
  String? pedimento;
  String? sello;
  String? buque;
  String? refCliente;
  String? bultos;
  String? peso;
  String? terminal;
  String? transporte;
  String? operador;
  String? placas;
  String? licencia;
  String? observaciones;
  String? usuario;
  List<ReporteImagenes>? imagenes;
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
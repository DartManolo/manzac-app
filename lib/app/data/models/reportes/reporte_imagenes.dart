import 'dart:convert';

class ReporteImagenes {
  String? idImagen;
  String? formato;
  int? fila;
  int? posicion;
  String? base64;
  String? tipo;

  ReporteImagenes({
    this.idImagen = "",
    this.formato = "",
    this.fila = 0,
    this.posicion = 0,
    this.base64 = "",
    this.tipo = "",
  });

  Map toJson() => {
    'idImagen'  : idImagen,
    'formato'   : formato,
    'fila'      : fila,
    'posicion'  : posicion,
    'base64'    : base64,
    'tipo'      : tipo,
  };

  ReporteImagenes.fromString(String jsonString) {
    var json = jsonDecode(jsonString);
    idImagen = json['login'] ?? "";
    formato = json['idUsuario'] ?? "";
    fila = json['usuario'] ?? 0;
    posicion = json['password'] ?? 0;
    base64 = json['perfil'] ?? "";
    tipo = json['nombre'] ?? "";
  }
}
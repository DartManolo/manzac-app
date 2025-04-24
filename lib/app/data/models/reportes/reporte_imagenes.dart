import 'dart:convert';

class ReporteImagenes {
  String? idTarja;
  String? idImagen;
  String? formato;
  int? fila;
  int? posicion;
  String? base64;
  String? tipo;
  String? usuario;

  ReporteImagenes({
    this.idTarja = "",
    this.idImagen = "",
    this.formato = "",
    this.fila = 0,
    this.posicion = 0,
    this.base64 = "",
    this.tipo = "",
    this.usuario = "",
  });

  Map toJson() => {
    'idTarja'   : idTarja,
    'idImagen'  : idImagen,
    'formato'   : formato,
    'fila'      : fila,
    'posicion'  : posicion,
    'base64'    : base64,
    'tipo'      : tipo,
    'usuario' :   usuario,
  };

  ReporteImagenes.fromString(String jsonString) {
    var json = jsonDecode(jsonString);
    idTarja = json['idTarja'] ?? "";
    idImagen = json['login'] ?? "";
    formato = json['idUsuario'] ?? "";
    fila = json['usuario'] ?? 0;
    posicion = json['password'] ?? 0;
    base64 = json['perfil'] ?? "";
    tipo = json['nombre'] ?? "";
    usuario = json['usuario'] ?? "";
  }

  List<ReporteImagenes> fromArray(List<dynamic>? array) {
    if(array != null) {
      List<ReporteImagenes> jsonArray = [];
      for(var json in array) {
        jsonArray.add(ReporteImagenes(
          idTarja: json['idTarja'] ?? "",
          idImagen: json['idImagen'] ?? "",
          formato: json['formato'] ?? "",
          fila: json['fila'] ?? 0,
          posicion: json['posicion'] ?? 0,
          base64: json['base64'] ?? "",
          tipo: json['tipo'] ?? "",
          usuario: json['usuario'] ?? "",
        ));
      }
      return jsonArray;
    }
    return [];
  }
}
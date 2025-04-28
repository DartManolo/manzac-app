import 'dart:convert';

import 'package:get/get.dart';

import '../../../services/tool_service.dart';

class ReporteImagenes {
  final ToolService _tool = Get.find<ToolService>();
  
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

  Map<String, dynamic> toJson() => {
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

  ReporteImagenes.fromApi(Map<String, dynamic> json) {
    idTarja = json['idTarja'].toString();
    idImagen = json['idImagen'].toString();
    formato = json['formato'].toString();
    fila = _tool.str2int(json['fila'].toString());
    posicion = _tool.str2int(json['posicion'].toString());
    base64 = json['base64'].toString();
    tipo = json['tipo'].toString();
    usuario = json['usuario'].toString();
  }
}
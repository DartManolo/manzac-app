import 'dart:convert';

import 'package:hive_ce_flutter/adapters.dart';

import '../hive_model.dart';

part 'reporte_imagenes.g.dart';

@HiveType(typeId: 5)
class ReporteImagenes extends HiveModel {
  static const String boxName = "reporte_imagenes";

  @HiveField(0)
  @override
  String? id;

  @HiveField(1)
  String? idTarja;

  @HiveField(2)
  String? idImagen;

  @HiveField(3)
  String? formato;

  @HiveField(4)
  int? fila;

  @HiveField(5)
  int? posicion;

  @HiveField(6)
  String? imagen;

  @HiveField(7)
  String? tipo;

  @HiveField(8)
  String? usuario;

  ReporteImagenes({
    this.idTarja = "",
    this.idImagen = "",
    this.formato = "",
    this.fila = 0,
    this.posicion = 0,
    this.imagen = "",
    this.tipo = "",
    this.usuario = "",
  });

  Map<String, dynamic> toJson() => {
    'id'        : id,
    'idTarja'   : idTarja,
    'idImagen'  : idImagen,
    'formato'   : formato,
    'fila'      : fila,
    'posicion'  : posicion,
    'imagen'    : imagen,
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
    imagen = json['imagen'] ?? "";
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
          imagen: json['imagen'] ?? "",
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
    fila = _str2int(json['fila'].toString());
    posicion = _str2int(json['posicion'].toString());
    imagen = json['imagen'].toString();
    tipo = json['tipo'].toString();
    usuario = json['usuario'].toString();
  }

  int _str2int(String cadena) {
    return int.tryParse(cadena) ?? 0;
  }
}
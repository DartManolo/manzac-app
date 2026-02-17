import 'dart:convert';

import 'package:hive_ce_flutter/adapters.dart';

import '../hive_model.dart';

part 'local_storage.g.dart';

@HiveType(typeId: 0)
class LocalStorage extends HiveModel {
  static const String boxName = "local_storage";
  
  @HiveField(0)
  @override
  String? id;

  @HiveField(1)
  int? version = 1;

  @HiveField(2)
  bool? login;

  @HiveField(3)
  String? idUsuario;

  @HiveField(4)
  String? usuario;

  @HiveField(5)
  String? password;

  @HiveField(6)
  String? perfil;

  @HiveField(7)
  String? nombre;

  @HiveField(8)
  String? token;

  @HiveField(9)
  bool? mayusculas;

  @HiveField(10)
  String? firmaOperaciones;

  @HiveField(11)
  String? firmaGerencia;

  @HiveField(12)
  String? idFirebase;

  LocalStorage({
    this.id,
    this.version = 1,
    this.login = false,
    this.idUsuario = "",
    this.usuario = "",
    this.password = "",
    this.perfil = "",
    this.nombre = "",
    this.token = "-",
    this.mayusculas = true,
    this.firmaOperaciones = "",
    this.firmaGerencia = "",
    this.idFirebase = "",
  });

  Map toJson() => {
    'id'                : id,
    'version'           : version,
    'login'             : login,
    'idUsuario'         : idUsuario,
    'usuario'           : usuario,
    'password'          : password,
    'perfil'            : perfil,
    'nombre'            : nombre,
    'token'             : token,
    'mayusculas'        : mayusculas,
    'firmaOperaciones'  : firmaOperaciones,
    'firmaGerencia'     : firmaGerencia,
    'idFirebase'        : idFirebase,
  };

  Map<String, dynamic> toMap() {
    return {
      'id'                : id,
      'version'           : version,
      'login'             : login,
      'idUsuario'         : idUsuario,
      'usuario'           : usuario,
      'password'          : password,
      'perfil'            : perfil,
      'nombre'            : nombre,
      'token'             : token,
      'mayusculas'        : mayusculas,
      'firmaOperaciones'  : firmaOperaciones,
      'firmaGerencia'     : firmaGerencia,
      'idFirebase'        : idFirebase,
    };
  }

  LocalStorage.fromString(String jsonString) {
    var json = jsonDecode(jsonString);
    id = json['id'] ?? false;
    login = json['login'] ?? false;
    idUsuario = json['idUsuario'] ?? "";
    usuario = json['usuario'] ?? "";
    password = json['password'] ?? "";
    perfil = json['perfil'] ?? "";
    nombre = json['nombre'] ?? "";
    token = json['token'] ?? "";
    mayusculas = json['mayusculas'] ?? false;
    firmaOperaciones = json['firmaOperaciones'] ?? "";
    firmaGerencia = json['firmaGerencia'] ?? "";
    idFirebase = json['idFirebase'] ?? "";
  }

  LocalStorage.fromMap(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    login = json['login'] ?? false;
    idUsuario = json['idUsuario'] ?? "";
    usuario = json['usuario'] ?? "";
    password = json['password'] ?? "";
    perfil = json['perfil'] ?? "";
    nombre = json['nombre'] ?? "";
    token = json['token'] ?? "";
    mayusculas = json['mayusculas'] ?? true;
    firmaOperaciones = json['firmaOperaciones'] ?? "";
    firmaGerencia = json['firmaGerencia'] ?? "";
    idFirebase = json['idFirebase'] ?? "";
  }

  LocalStorage fromJson(Map<String, dynamic>? json) {
    return json != null ? LocalStorage(
      id: json['id'] ?? "",
      version: json['version'] ?? 1,
      login: json['login'] ?? false,
      idUsuario: json['idUsuario'] ?? "",
      usuario: json['usuario'] ?? "",
      password: json['password'] ?? "",
      perfil: json['perfil'] ?? "",
      nombre: json['nombre'] ?? "",
      token: json['token'] ?? "",
      mayusculas: json['mayusculas'] ?? true,
      firmaOperaciones: json['firmaOperaciones'] ?? "",
      firmaGerencia: json['firmaGerencia'] ?? "",
      idFirebase: json['idFirebase'] ?? "",
    ) : LocalStorage();
  }

  List<LocalStorage> fromArray(List<dynamic>? array) {
    if(array != null) {
      List<LocalStorage> jsonArray = [];
      for(var json in array) {
        jsonArray.add(LocalStorage(
          id: json['id'] ?? "",
          version: json['version'] ?? 1,
          login: json['login'] ?? false,
          idUsuario: json['idUsuario'] ?? "",
          usuario: json['usuario'] ?? "",
          password: json['password'] ?? "",
          perfil: json['perfil'] ?? "",
          nombre: json['nombre'] ?? "",
          token: json['token'] ?? "",
          mayusculas: json['mayusculas'] ?? true,
          firmaOperaciones: json['firmaOperaciones'] ?? "",
          firmaGerencia: json['firmaGerencia'] ?? "",
          idFirebase: json['idFirebase'] ?? "",
        ));
      }
      return jsonArray;
    }
    return [LocalStorage()];
  }
}
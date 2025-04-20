import 'dart:convert';

class LocalStorage {
  static const int _localStorageVersion = 1;

  String? tabla = "local_storage";
  int? version = _localStorageVersion;
  bool? login;
  String? idUsuario;
  String? usuario;
  String? password;
  String? perfil;
  String? nombre;
  String? token;
  bool? mayusculas;
  String? firmaOperaciones;
  String? firmaGerencia;

  LocalStorage({
    this.version = _localStorageVersion,
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
  });

  Map toJson() => {
    'tabla'             : tabla,
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
  };

  Map<String, dynamic> toMap() {
    return {
      'tabla'             : tabla,
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
    };
  }

  LocalStorage.fromString(String jsonString) {
    var json = jsonDecode(jsonString);
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
  }

  LocalStorage.fromMap(Map<String, dynamic> json) {
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
  }

  LocalStorage fromJson(Map<String, dynamic>? json) {
    return json != null ? LocalStorage(
      version: json['version'] ?? _localStorageVersion,
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
    ) : LocalStorage();
  }

  List<LocalStorage> fromArray(List<dynamic>? array) {
    if(array != null) {
      List<LocalStorage> jsonArray = [];
      for(var json in array) {
        jsonArray.add(LocalStorage(
          version: json['version'] ?? _localStorageVersion,
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
        ));
      }
      return jsonArray;
    }
    return [LocalStorage()];
  }
}
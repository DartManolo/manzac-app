import 'dart:convert';

class LocalStorage {
  static const int _localStorageVersion = 2;

  String? tabla = "local_storage";
  int? version = _localStorageVersion;
  bool? login;
  String? idUsuario;
  String? usuario;
  String? password;
  String? perfil;
  String? nombre;
  String? token;

  LocalStorage({
    this.version = _localStorageVersion,
    this.login = false,
    this.idUsuario = "",
    this.usuario = "",
    this.password = "",
    this.perfil = "",
    this.nombre = "",
    this.token = "-",
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
  }

  LocalStorage.fromMap(Map<String, dynamic> json) {
    login = json['login'] ?? false;
    idUsuario = json['idUsuario'] ?? "";
    usuario = json['usuario'] ?? "";
    password = json['password'] ?? "";
    perfil = json['perfil'] ?? "";
    nombre = json['nombre'] ?? "";
    token = json['token'] ?? "";
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
        ));
      }
      return jsonArray;
    }
    return [LocalStorage()];
  }
}
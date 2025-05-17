import 'dart:convert';

import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../services/tool_service.dart';
import '../../utils/literals.dart';
import '../models/login/login_data.dart';
import '../models/usuarios/notificacion_forbiden.dart';

class UsuariosProvider {
  final ApiService _api = Get.find<ApiService>();
  final ToolService _tool = Get.find<ToolService>();

  Future<String?> altaUsuarioAsync(LoginData usuario) async {
    try {
      var result = await _api.post(
        "api/usuarios/altaUsuario",
        usuario
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<List<LoginData>?> obtenerUsuariosAsync(String usuario) async {
    try {
      List<LoginData> result = [];
      var resultApi = await _api.get(
        "api/usuarios/obtenerUsuarios/$usuario",
      );
      if(_tool.isArray(jsonDecode(resultApi!))) {
        Iterable apiResultJson = jsonDecode(resultApi);
        result = List<LoginData>.from(
          apiResultJson.map((json) => LoginData.fromJson(json))
        );
      } else {
        var resultSingle = LoginData.fromJson(jsonDecode(resultApi));
        result.add(resultSingle);
      }
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<String?> verificarEstatusAsync(String usuario) async {
    try {
      var result = await _api.get(
        "api/usuarios/verificarEstatus/$usuario"
      );
      if(result != null) {
        if(result == Literals.apiTrue) {
          return Literals.statusActivo;
        } else {
          return Literals.statusInactivo;
        }
      }
      return null;
    } catch(e) {
      return null;
    }
  }

  Future<bool> actualizarEstatusAsync(String usuario, String estatus) async {
    try {
      var result = await _api.get(
        "api/usuarios/actualizarEstatus/$usuario/$estatus"
      );
      return result == Literals.apiTrue;
    } catch(e) {
      return false;
    }
  }

  Future<String?> validarUsuarioAsync(String usuario) async {
    try {
      var result = await _api.get(
        "api/usuarios/validarUsuario/$usuario"
      );
      return result;
    } catch(e) {
      return null;
    }
  }

  Future<bool> notificarAdminsForbidenLogoutAsync(NotificacionForbiden notificacion) async {
    try {
      var result = await _api.post(
        "api/usuarios/notificarAdminsForbidenLogout",
        notificacion
      );
      return result == Literals.apiTrue;
    } catch(e) {
      return false;
    }
  }
}
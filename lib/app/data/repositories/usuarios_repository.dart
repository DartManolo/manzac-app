import 'package:get/get.dart';

import '../models/login/login_data.dart';
import '../providers/usuarios_provider.dart';

class UsuariosRepository {
  Future<String?> altaUsuarioAsync(LoginData usuario) async {
    return await Get.find<UsuariosProvider>().altaUsuarioAsync(usuario);
  }

  Future<List<LoginData>?> obtenerUsuariosAsync(String usuario) async {
    return await Get.find<UsuariosProvider>().obtenerUsuariosAsync(usuario);
  }

  Future<String?> verificarEstatusAsync(String usuario) async {
    return await Get.find<UsuariosProvider>().verificarEstatusAsync(usuario);
  }

  Future<bool> actualizarEstatusAsync(String usuario, String estatus) async {
    return await Get.find<UsuariosProvider>().actualizarEstatusAsync(usuario,estatus);
  }

  Future<String?> validarUsuarioAsync(String usuario) async {
    return await Get.find<UsuariosProvider>().validarUsuarioAsync(usuario);
  }
}
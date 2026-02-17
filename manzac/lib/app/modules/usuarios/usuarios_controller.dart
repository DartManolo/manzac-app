import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/login/login_data.dart';
import '../../utils/get_injection.dart';
import '../../utils/literals.dart';
import '../../widgets/containers/basic_bottom_sheet_container.dart';
import '../../widgets/forms/nuevo_usuario_form.dart';

class UsuariosController extends GetInjection {
  TextEditingController usuario = TextEditingController();
  FocusNode usuarioFocus = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  TextEditingController nombre = TextEditingController();
  FocusNode nombreFocus = FocusNode();
  TextEditingController apellido = TextEditingController();
  FocusNode apellidoFocus = FocusNode();
  bool usuarioAdmin = false;

  List<LoginData>? listaUsuarios = [];

  String usuarioActual = "";
  String idLocalStorage = "";

  bool cargando = true;
  bool conInternet = true;

  @override
  Future<void> onReady() async {
    await _ready();
    super.onReady();
  }

  Future<void> _ready() async {
    try {
      idLocalStorage = await getIdLocalStorage();
      var localStorage = await storage.get<LocalStorage>(idLocalStorage);
      usuarioActual = localStorage!.usuario!;
      await tool.wait();
      conInternet = await tool.isOnline();
      if(!conInternet) {
        return;
      }
      await _cargarListaUsuarios();
    } finally {
      cargando = false;
      update();
    }
  }

  void cerrar() {
    Get.back();
  }

  Future<void> recargar() async {
    cargando = true;
    conInternet = true;
    update();
    await _ready();
  }

  void nuevoUsuarioForm() {
    var context = Get.context;
    usuario.text = "";
    password.text = "";
    nombre.text = "";
    apellido.text = "";
    usuarioAdmin = false;
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: NuevoUsuarioForm(
          usuario: usuario,
          usuarioFocus: usuarioFocus,
          password: password,
          passwordFocus: passwordFocus,
          nombre: nombre,
          nombreFocus: nombreFocus,
          apellido: apellido,
          apellidoFocus: apellidoFocus,
          esAdmin: _usuarioAdmin,
          guardarUsuario: _guardarUsuario,
        ),
      ),
    );
  }

  Future<void> cambiarEstatus(LoginData? usuario, String estatus) async {
    try {
      var verify = await ask("Atención!", "¿Desea marcar al usuario como $estatus?");
      if(!verify) {
        return;
      }
      isBusy();
      conInternet = await tool.isOnline();
      if(!conInternet) {
        await tool.wait(1);
        isBusy(false);
        return;
      }
      var actualizar = await usuariosRepository.actualizarEstatusAsync(usuario!.usuario!, estatus);
      if(!actualizar) {
        throw Exception();
      }
      await _cargarListaUsuarios();
      msg("Usuario actualizado correctamente", MsgType.success);
    } catch(e) {
      msg("Ocurrió un error al intentar cambiar estatus de usuario", MsgType.error);
    } finally {
      update();
    }
  }

  Future<void> _cargarListaUsuarios() async {
    try {
      listaUsuarios = [];
      var usuarios = await usuariosRepository.obtenerUsuariosAsync("TODOS");
      if(usuarios == null) {
        msg("Ocurrió un error al intentar cargar la lista de usuarios", MsgType.error);
        return;
      }
      for (var i = 0; i < usuarios.length; i++) {
        if(usuarios[i].usuario == usuarioActual) {
          continue;
        }
        listaUsuarios!.add(usuarios[i]);
      }
    } finally { }
  }

  Future<void> _guardarUsuario() async {
    try {
      if(!_validarForm()) {
        return;
      }
      var verify = await ask("Guardar usuario", "¿Desea continuar?");
      if(!verify) {
        return;
      }
      isBusy();
      var usuarioAlta = LoginData(
        usuario: usuario.text.toLowerCase(),
        token: password.text,
        nombres: nombre.text,
        apellidos: apellido.text,
        status: Literals.statusPassTemporal,
        perfil: usuarioAdmin ? Literals.perfilAdministrador : Literals.perfilUsuario,
      );
      var result = await usuariosRepository.altaUsuarioAsync(usuarioAlta);
      if(result == null) {
        throw Exception();
      }
      if(result == Literals.usuarioExiste) {
        msg("Ya existe un usuario con ese corrreo", MsgType.warning);
        return;
      }
      tool.closeBottomSheet();
      await _cargarListaUsuarios();
      msg("Usuario creado correctamente", MsgType.success);
    } catch(e) {
      tool.closeBottomSheet();
      msg("Ocurrió un error al intentar guardar usuario", MsgType.error);
    } finally {
      update();
    }
  }

  void _usuarioAdmin(bool cAdmin) {
    usuarioAdmin = cAdmin;
  }

  bool _validarForm() {
    var thisContext = Get.context;
    var correcto = false;
    var mensaje = "";
    if(tool.isNullOrEmpty(usuario)) {
      mensaje = "Escriba el usuario/correo";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else if(!tool.isEmail(usuario.text)) {
      mensaje = "Formato de correo es incorrecto";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else if(tool.isNullOrEmpty(password)) {
      mensaje = "Escriba la contraseña";
      FocusScope.of(thisContext!).requestFocus(passwordFocus);
    } else if(tool.isNullOrEmpty(nombre)) {
      mensaje = "Escriba el nombre";
      FocusScope.of(thisContext!).requestFocus(nombreFocus);
    } else if(tool.isNullOrEmpty(apellido)) {
      mensaje = "Escriba el apellido";
      FocusScope.of(thisContext!).requestFocus(apellidoFocus);
    } else {
      _unfocus();
      correcto = true;
      usuarioFocus.unfocus();
      passwordFocus.unfocus();
    }
    if(!correcto) {
      toast(mensaje);
    }
    return correcto;
  }

  void _unfocus() {
    usuarioFocus.unfocus();
    passwordFocus.unfocus();
    nombreFocus.unfocus();
    apellidoFocus.unfocus();
  }
}
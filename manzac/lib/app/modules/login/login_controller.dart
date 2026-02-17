import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/login/login_form.dart';
import '../../utils/get_injection.dart';
import '../../utils/literals.dart';
import '../../widgets/columns/password_column.dart';
import '../../widgets/containers/basic_bottom_sheet_container.dart';
import '../home/home_binding.dart';
import '../home/home_page.dart';

class LoginController extends GetInjection {
  TextEditingController usuario = TextEditingController();
  FocusNode usuarioFocus = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  TextEditingController nuevaPassword = TextEditingController();
  FocusNode nuevaPasswordFocus = FocusNode();
  TextEditingController repetirPassword = TextEditingController();
  FocusNode repetirPasswordFocus = FocusNode();

  bool ocultarPassword = true;
  bool mantenerSesion = false;
  bool usuarioTextEnabled = true;

  String idLocalStorage = "";

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    idLocalStorage = await getIdLocalStorage();
    var localStorage = await storage.get<LocalStorage>(idLocalStorage);
    usuario.text = localStorage!.usuario!;
    usuarioTextEnabled = localStorage.usuario == "";
    update();
    return;
  }

  Future<void> iniciarSesion() async {
    try {
      if(!_validarForm()) {
        return;
      }
      isBusy();
      var localStorage = await storage.get<LocalStorage>(idLocalStorage);
      var loginForm = LoginForm(
        usuario: usuario.text.toLowerCase(),
        password: password.text,
        firebase: localStorage!.idFirebase,
      );
      var result = await loginRepository.iniciarSesionAsync(loginForm);
      if(result == null) {
        msg("Usuario y/o contraseña incorrecto", MsgType.warning);
        return;
      }
      if(result.status == Literals.statusInactivo) {
        msg("El usuario se encuentra INACTIVO. Consulte con su administrador", MsgType.warning);
        return;
      }
      GetInjection.administrador = result.perfil == Literals.perfilAdministrador;
      GetInjection.perfil = result.perfil!;
      localStorage.token = result.token;
      localStorage.idUsuario = result.idSistema;
      localStorage.usuario = loginForm.usuario;
      localStorage.login = mantenerSesion;
      localStorage.perfil = result.perfil;
      localStorage.nombre = "${result.nombres} ${result.apellidos}";
      await storage.save<LocalStorage>(localStorage);
      var configuracionFirmas = await configuracionRepository.obtenerConfiguracionAsync("firmas");
      if(configuracionFirmas != null) {
        localStorage.firmaOperaciones = configuracionFirmas.firmaOperador;
        localStorage.firmaGerencia = configuracionFirmas.firmaGerencia;
        await storage.save<LocalStorage>(localStorage);
      }
      isBusy(false);
      if(result.status == Literals.statusPassTemporal) {
        _abrirActualizaPasswordForm();
        return;
      }
      Get.offAll(
        const HomePage(),
        binding: HomeBinding(),
        transition: Transition.rightToLeft,
        duration: 1.5.seconds,
      );
    } catch(e) {
      msg("Ocurrió un error al iniciar sesión", MsgType.error);
    } finally {
      
    }
  }

  Future<void> recuperarPassword() async {
    try {
      if(!_validarFormPassword()) {
        return;
      }
      var verify = await ask("Recuperar contraseña", "¿Desea continuar con el proceso?");
      if(!verify) {
        return;
      }
      isBusy();
      var validar = await usuariosRepository.validarUsuarioAsync(usuario.text);
      if(validar == null) {
        throw Exception();
      }
      if(validar != Literals.usuarioOk) {
        var detalleErr = "No especificado";
        if(validar == Literals.usuarioNoExiste) {
          detalleErr = "usuario NO registrado";
        } else if(validar == Literals.usuarioInactivo) {
          detalleErr = "usuario INACTIVO";
        }
        msg('No es posible recuperar contraseña ($detalleErr)', MsgType.warning);
        return;
      }
      var passwordForm = LoginForm(
        usuario: usuario.text,
      );
      var nuevaPassword = await loginRepository.recuperarPasswordAsync(passwordForm);
      if(nuevaPassword == null || nuevaPassword == Literals.newPasswordError) {
        throw Exception();
      }
      if(nuevaPassword == Literals.newPasswordNoUsuario) {
        msg('No se encontró ningun registro con el usuario proporcionado.', MsgType.warning);
        return;
      }
      await tool.wait(1);
      msg('Contraseña enviada a su correo; puede tardar unos minutos en llegar, le sugerimos revisar su bandeja de Spam', MsgType.success);
      return;
    } catch(e) {
      msg('Ocurrio un error al intentar recuperar contraseña', MsgType.error);
      return;
    }
  }

  void verPassword() {
    ocultarPassword = !ocultarPassword;
    update();
  }

  void mantenerSesionCheck(bool? value) {
    mantenerSesion = value!;
    update();
  }

  void _abrirActualizaPasswordForm() {
    password.text = "";
    var context = Get.context;
    nuevaPassword.text = "";
    repetirPassword.text = "";
    showMaterialModalBottomSheet(
      context: context!,
      expand: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => BasicBottomSheetContainer(
        context: context,
        cerrar: true,
        child: PasswordColumn(
          nuevaPassword: nuevaPassword,
          nuevaPasswordFocus: nuevaPasswordFocus,
          repetirPassword: repetirPassword,
          repetirPasswordFocus: repetirPasswordFocus,
          esNueva: false,
          guardarPassword: _actualizarPassword,
        ),
      ),
    );
  }

  Future<void> _actualizarPassword() async {
    try {
      if(!_validarFormActualizarPassword()) {
        return;
      }
      isBusy();
      var loginForm = LoginForm(
        usuario: usuario.text,
        password: nuevaPassword.text,
      );
      var result = await loginRepository.actualizarPasswordAsync(loginForm);
      if(result == null || !result) {
        throw Exception();
      }
      await tool.wait(1);
      tool.closeBottomSheet();
      msg('Usuario actualizado. Ya puede iniciar sesión con su nueva contraseña.', MsgType.success);
    } catch(e) {
      msg('Ocurrio un error al intentar actualizar contraseña', MsgType.error);
      return;
    }
  }

  bool _validarForm() {
    var thisContext = Get.context;
    var correcto = false;
    var mensaje = "";
    if(tool.isNullOrEmpty(usuario)) {
      mensaje = "Escriba el usuario";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else if(!tool.isEmail(usuario.text)) {
      mensaje = "Formato de usuario es incorrecto";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else if(tool.isNullOrEmpty(password)) {
      mensaje = "Escriba la contraseña";
      FocusScope.of(thisContext!).requestFocus(passwordFocus);
    } else {
      correcto = true;
      usuarioFocus.unfocus();
      passwordFocus.unfocus();
    }
    if(!correcto) {
      toast(mensaje);
    }
    return correcto;
  }

  bool _validarFormPassword() {
    var thisContext = Get.context;
    var correcto = false;
    var mensaje = "";
    if(tool.isNullOrEmpty(usuario)) {
      mensaje = "Escriba el usuario";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else if(!tool.isEmail(usuario.text)) {
      mensaje = "El usuario no es válido";
      FocusScope.of(thisContext!).requestFocus(usuarioFocus);
    } else {
      correcto = true;
      usuarioFocus.unfocus();
      passwordFocus.unfocus();
    }
    if(!correcto) {
      toast(mensaje);
    }
    return correcto;
  }

  bool _validarFormActualizarPassword() {
    var correcto = false;
    var mensaje = "";
    if(tool.isNullOrEmpty(nuevaPassword)) {
      mensaje = "Escriba la nueva contraseña";
    } else if(tool.isNullOrEmpty(repetirPassword)) {
      mensaje = "Escriba repetir contraseña";
    } else if(nuevaPassword.text != repetirPassword.text) {
      mensaje = "Las contraseñas NO coinciden";
    } else {
      correcto = true;
    }
    if(!correcto) {
      toast(mensaje);
    }
    return correcto;
  }
}
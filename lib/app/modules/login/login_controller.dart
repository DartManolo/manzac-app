import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/local_storage/local_storage.dart';
import '../../data/models/login/login_form.dart';
import '../../utils/get_injection.dart';
import '../../utils/literals.dart';
import '../home/home_binding.dart';
import '../home/home_page.dart';

class LoginController extends GetInjection {
  TextEditingController usuario = TextEditingController();
  FocusNode usuarioFocus = FocusNode();
  TextEditingController password = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  bool ocultarPassword = true;
  bool mantenerSesion = false;

  @override
  Future<void> onInit() async {
    await _init();
    super.onInit();
  }

  Future<void> _init() async {
    var localStorage = await storage.get<LocalStorage>(LocalStorage());
    usuario.text = localStorage!.usuario!;
    update();
    return;
  }

  Future<void> iniciarSesion() async {
    try {
      if(!_validarForm()) {
        return;
      }
      isBusy();
      var localStorage = await storage.get<LocalStorage>(LocalStorage());
      var loginForm = LoginForm(
        usuario: usuario.text.toLowerCase(),
        password: password.text,
      );
      var result = await loginRepository.iniciarSesionAsync(loginForm);
      if(result == null) {
        return;
      }
      GetInjection.administrador = result.perfil == Literals.perfilAdministrador;
      GetInjection.perfil = result.perfil!;
      localStorage!.token = result.token;
      localStorage.idUsuario = result.idSistema;
      localStorage.usuario = loginForm.usuario;
      localStorage.login = mantenerSesion;
      localStorage.perfil = result.perfil;
      await storage.update(localStorage);
      isBusy(false);
      Get.offAll(
        const HomePage(),
        binding: HomeBinding(),
        transition: Transition.rightToLeft,
        duration: 1.5.seconds,
      );
    } catch(e) {

    } finally {
      
    }
  }

  Future<void> recuperarPassword() async {

  }

  void verPassword() {
    ocultarPassword = !ocultarPassword;
    update();
  }

  void mantenerSesionCheck(bool? value) {
    mantenerSesion = value!;
    update();
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
      FocusScope.of(thisContext!).requestFocus(passwordFocus);
    } else if(tool.isNullOrEmpty(password)) {
      mensaje = "Escriba la contraseña";
      FocusScope.of(thisContext!).requestFocus(passwordFocus);
    } else {
      correcto = true;
      usuarioFocus.unfocus();
      passwordFocus.unfocus();
    }
    if(!correcto) {
      tool.toast(mensaje);
    }
    return correcto;
  }
}
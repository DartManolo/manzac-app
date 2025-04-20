import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../utils/get_injection.dart';
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

  List<String> listaUsuarios = [];

  bool cargando = true;
  bool conInternet = true;

  @override
  Future<void> onReady() async {
    await _ready();
    super.onReady();
  }

  Future<void> _ready() async {
    try {
      await tool.wait();
      conInternet = await tool.isOnline();
      if(!conInternet) {
        return;
      }
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

  Future<void> _guardarUsuario() async {
    try {
      var verify = await ask("Guardar usuario", "¿Desea continuar?");
      if(!verify) {
        return;
      }
      //tool.closeBottomSheet();
    } catch(e) {
      msg("Ocurrió un error al intentar guardar usuario", MsgType.error);
    }
  }

  void _usuarioAdmin(bool cAdmin) {
    usuarioAdmin = cAdmin;
  }
}
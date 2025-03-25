import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../utils/color_list.dart';
import '../../widgets/buttons/solid_button.dart';
import '../../widgets/textforms/password_textform.dart';
import '../../widgets/textforms/standard_textform.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget with WidgetsBindingObserver {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(child: SizedBox()),
            StandardTextform(
              controller: c.usuario,
              focusNode: c.usuarioFocus,
              text: "Usuario",
              ltrbp: const [20, 10, 20, 10],
              icon: MaterialIcons.person,
            ),
            PasswordTextform(
              controller: c.password,
              focusNode: c.passwordFocus,
              obscureText: c.ocultarPassword,
              obscureTextFunc: c.verPassword,
              text: "Contraseña",
              ltrbp: const [20, 10, 20, 0],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20,),
                Checkbox(
                  onChanged: c.mantenerSesionCheck,
                  value: c.mantenerSesion,
                  activeColor: Color(ColorList.sys[0]),
                ),
                Text(
                  'Mantener sesión iniciada',
                  style: TextStyle(
                    color: Color(ColorList.sys[0]),
                  ),
                ),
              ],
            ),
            SolidButton(
              texto: "Iniciar Sesión",
              icono: MaterialIcons.login,
              onPressed: c.iniciarSesion,
              textoColor: ColorList.sys[3],
              fondoColor: ColorList.sys[0],
              ltrbm: const [10, 10, 10, 0],
              onLongPress: () {},
            ),
            SolidButton(
              texto: "Recuperar contraseña",
              icono: MaterialIcons.refresh,
              onPressed: c.recuperarPassword,
              textoColor: ColorList.sys[3],
              fondoColor: ColorList.sys[1],
              ltrbm: const [10, 0, 10, 0],
              onLongPress: () {},
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../utils/color_list.dart';
import '../buttons/solid_button.dart';
import '../containers/card_scrollable_container.dart';
import '../containers/titulo_container.dart';
import '../switchs/opcion_switch.dart';
import '../textforms/password_textform.dart';
import '../textforms/standard_textform.dart';

class NuevoUsuarioForm extends StatelessWidget {
  final TextEditingController? usuario;
  final FocusNode? usuarioFocus;
  final TextEditingController? password;
  final FocusNode? passwordFocus;
  final TextEditingController? nombre;
  final FocusNode? nombreFocus;
  final TextEditingController? apellido;
  final FocusNode? apellidoFocus;
  final void Function(bool) esAdmin;
  final void Function() guardarUsuario;
  const NuevoUsuarioForm({
    super.key,
    this.usuario,
    this.usuarioFocus,
    this.password,
    this.passwordFocus,
    this.nombre,
    this.nombreFocus,
    this.apellido,
    this.apellidoFocus,
    required this.esAdmin,
    required this.guardarUsuario,
  });

  @override
  Widget build(BuildContext context) {
    bool admin = false;
    bool nuevaPassword = true;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TituloContainer(
            texto: "Crear nuevo usuario\n(*) Los campos son obligatorios",
            ltrbp: const [10, 0, 0, 0],
            size: 16,
          ),
          Expanded(
            child: CardScrollableContainer(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0,),
              children: [
                StandardTextform(
                  controller: usuario,
                  focusNode: usuarioFocus,
                  icon: Icons.email_outlined,
                  text: 'Correo electrónico *',
                  ltrbp: const [0, 10, 0, 10],
                ),
                PasswordTextform(
                  controller: password,
                  focusNode: passwordFocus,
                  obscureText: nuevaPassword,
                  obscureTextFunc: () {
                    setState(() {
                      nuevaPassword = !nuevaPassword;
                    });
                  },
                  text: "Contraseña temporal *",
                  icon: MaterialIcons.lock,
                  ltrbp: const [0, 10, 0, 10],
                ),
                SizedBox(height: 10,),
                StandardTextform(
                  controller: nombre,
                  focusNode: nombreFocus,
                  icon: Icons.person,
                  text: 'Nombre *',
                  ltrbp: const [0, 10, 0, 10],
                ),
                StandardTextform(
                  controller: apellido,
                  focusNode: apellidoFocus,
                  icon: Icons.person,
                  text: 'Apellido *',
                  ltrbp: const [0, 10, 0, 10],
                ),
                OpcionSwitch(
                  value: admin,
                  text: "Usuario administrador",
                  onChanged: (c) {
                    setState(() {
                      admin = c;
                    });
                    esAdmin(admin);
                  },
                ),
              ],
            ),
          ),
          SolidButton(
            texto: "Guardar usuario",
            icono: MaterialIcons.save,
            fondoColor: ColorList.sys[1],
            textoColor: ColorList.sys[3],
            ltrbm: const [0, 0, 0, 0,],
            onPressed: guardarUsuario,
            onLongPress: () {},
          ),
        ],
      );
    });
  }
}
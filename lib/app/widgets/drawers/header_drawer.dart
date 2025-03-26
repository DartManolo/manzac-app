import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/color_list.dart';

class HeaderDrawer extends StatelessWidget {
  final String nombre;
  final String usuario;
  const HeaderDrawer({
    super.key,
    required this.nombre,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: AutoSizeText(
        nombre,
        maxLines: 1,
        minFontSize: 7,
        maxFontSize: 16,
      ),
      accountEmail: AutoSizeText(
        usuario,
        maxLines: 1,
        minFontSize: 7,
        maxFontSize: 14,
      ),
      currentAccountPicture: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/logo-manzac.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      decoration: BoxDecoration(color: Color(ColorList.sys[0])),
    );
  }
}
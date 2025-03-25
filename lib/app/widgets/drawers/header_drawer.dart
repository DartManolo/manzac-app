import 'package:flutter/material.dart';

import '../../utils/color_list.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text('Sandra Adams'),
      accountEmail: Text('sandra_a88@gmail.com'),
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
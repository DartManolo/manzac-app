import 'package:flutter/material.dart';

import '../../utils/color_list.dart';

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool selected;
  final void Function() accion; 

  const ItemDrawer({
    super.key,
    required this.icon,
    required this.text,
    this.selected = false,
    required this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: selected ? Color(ColorList.sys[0]) : Color(ColorList.sys[1]),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Color(ColorList.sys[0]),
          fontWeight: FontWeight.w500,
        ),
      ),
      tileColor: selected ? Color(ColorList.sys[0]).withValues(alpha: 0.2) : null,
      onTap: () {
        Navigator.pop(context);
        accion();
      },
    );
  }
}
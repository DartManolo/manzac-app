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
      leading: Icon(icon, color: selected ? Color(ColorList.sys[0]) : Colors.grey[700]),
      title: Text(text),
      tileColor: selected ? Color(ColorList.sys[0]).withValues(alpha: 0.2) : null,
      onTap: () {
        Navigator.pop(context);
        accion();
      },
    );
  }
}
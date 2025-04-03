import 'package:flutter/material.dart';

class CardScrollableContainer extends StatelessWidget {
  final List<Widget> children;
  final int fondo;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final CrossAxisAlignment columnAlign;
  final MainAxisAlignment mainAlign;
  final double width;
  final double? height;
  final double radius;
  const CardScrollableContainer({
    super.key,
    this.children = const [],
    this.fondo = 0xFFEAECEE,
    this.padding = const EdgeInsets.all(10,),
    this.margin = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    this.columnAlign = CrossAxisAlignment.start,
    this.mainAlign = MainAxisAlignment.start,
    this.width = double.infinity,
    this.height,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color(fondo),
        border: Border.all(
          color: Color(fondo),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: columnAlign,
          mainAxisAlignment: mainAlign,
          children: children,
        ),
      ),
    );
  }
}
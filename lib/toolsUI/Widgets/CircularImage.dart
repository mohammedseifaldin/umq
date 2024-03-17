import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  CircularImage(this.size,this.child);

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) =>ClipRRect(
  borderRadius: BorderRadius.circular(size/2),
  child: Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(size/2)),
      color: Colors.grey.shade400,
    ),
    child: child,
  ),);
}

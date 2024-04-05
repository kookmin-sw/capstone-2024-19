import 'package:flutter/material.dart';

class Blank extends StatelessWidget{
  final double width;
  final double height;

  const Blank(
    this.width,
    this.height,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
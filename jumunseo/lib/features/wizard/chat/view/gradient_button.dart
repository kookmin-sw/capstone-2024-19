import 'package:flutter/material.dart';
import 'package:jumunseo/config/theme/app_color.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onButtonPress;
  final String message;

  const GradientButton({
    required this.onButtonPress,
    required this.message,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onButtonPress();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorStyles.mainColor,
              ColorStyles.secondMainColor,
            ],
          ),
        ),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
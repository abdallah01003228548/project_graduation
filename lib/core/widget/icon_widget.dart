import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.backgroundColor,
    required this.height,
    required this.onPressed,
    required this.text,
    required this.textColor,
    required this.textStyle,
    required this.width,
  });

  final Color backgroundColor;
  final String text;
  final Color textColor;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text,
        style: textStyle.copyWith(
          color: textColor,
        ),
        ),
      ),
    );
  }
}

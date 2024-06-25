import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.icon,
    this.fontSize = 20, this.fontFamily,
  });

  final Color color;
  final String text;
  final VoidCallback onTap; // darim migim k ontap yek functione .
  final double width;
  final Color textColor;
  final IconData? icon;
  final double fontSize;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Row(
                      children: [
                        Icon(
                          icon,
                          color: textColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontFamily,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

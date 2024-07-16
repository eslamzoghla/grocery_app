import 'package:flutter/material.dart';
import 'package:grocery/shared/styles/colors.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.buttonColor = green,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback onTap;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Row(
          children: [
            const Spacer(),
            Text(
              text,
              style: textStyle ??
                  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor),
            ),
            const Spacer(),
            Icon(
              icon.icon,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
  }
}

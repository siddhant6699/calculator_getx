import 'package:calculator_app_getx/utils/konstants.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.buttonText,
      this.onTap,
      this.buttonTextColor,
      this.buttonColor})
      : super(key: key);

  final String buttonText;
  final Color? buttonTextColor;
  final Color? buttonColor;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor ??
                (isDarkTheme == true
                    ? defaultKeyboardBgColor
                    : defaultKeyboardBgColor.withOpacity(0.1)),
            shape: BoxShape.circle),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                color: buttonTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

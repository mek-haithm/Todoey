import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          kMainColor,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          kBackground,
        ),
      ),
      child: Text(
        text,
        style: kButtonTextStyle(context),
      ),
    );
  }
}

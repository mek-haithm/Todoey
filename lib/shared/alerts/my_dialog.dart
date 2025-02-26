import 'package:flutter/material.dart';
import 'package:todey/shared/constants/colors.dart';
import 'package:todey/shared/widgets/my_text_field.dart';
import '../constants/text_styles.dart';

class MyDialog extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final String firstButton;
  final String secondButton;
  final VoidCallback onFirstButtonPressed;
  final VoidCallback onSecondButtonPressed;

  const MyDialog({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.firstButton,
    required this.secondButton,
    required this.onFirstButtonPressed,
    required this.onSecondButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackground,
      title: Text(
        title,
        style: kMessageTitleTextStyle(context),
      ),
      content: MyTextField(hintText: hint, controller: controller),
      actions: [
        InkWell(
          onTap: onFirstButtonPressed,
          child: SizedBox(
            width: 40.0,
            height: 25.0,
            child: Center(
              child: Text(
                firstButton,
                style: kButtonAlertTextStyle(context),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onSecondButtonPressed,
          child: SizedBox(
            width: 40.0,
            height: 25.0,
            child: Center(
              child: Text(
                secondButton,
                style: kButtonAlertTextStyle(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

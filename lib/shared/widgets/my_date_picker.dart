import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class MyDatePicker extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final String dueDate;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool allowOldDate;

  const MyDatePicker({
    super.key,
    required this.onDateSelected,
    required this.dueDate,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.allowOldDate = true,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: allowOldDate ? (firstDate ?? DateTime(2000)) : DateTime.now(),
      lastDate: lastDate ?? DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: kMainColor,
            hintColor: kMainColor,
            colorScheme: const ColorScheme.light(primary: kMainColor),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: kBackground,
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kMainColor,
              hintColor: kMainColor,
              colorScheme: const ColorScheme.light(primary: kMainColor),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor: kBackground,
            ),
            child: child!,
          );
        },
      );
      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateSelected(pickedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          dueDate,
          style: dueDate == '' || dueDate == 'dueDate'.tr
              ? const TextStyle(
            color: Colors.grey,
            fontFamily: "ibmFont",
          )
              : kSmallTextStyle(context),
        ),
      ),
    );
  }
}

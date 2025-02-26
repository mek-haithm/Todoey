import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/language/locale_controller.dart';
import '../../../shared/constants/text_styles.dart';

class CategoryBox extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final int count;

  const CategoryBox({
    super.key,
    required this.name,
    required this.onTap,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(-2, -2),
                  blurRadius: 4,
                  spreadRadius: -1,
                ),
              ],
            ),
            child: Center(
              child: Text(
                name.tr,
                style: kInactiveBoldTextStyle(context).copyWith(
                  color: Colors.grey.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 5.0,
            right: LocalController().isEnglish
                ? 5.0 : null,
            left: LocalController().isEnglish
                ? null : 5.0,
            child: Text(
              "$count",
              style: kButtonAlertTextStyle(context).copyWith(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  const TaskTile({
    required this.task,
    required this.onToggle,
    this.onTap,
    this.isCompleted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String truncateText(String text, int maxLength) {
      if (text.length <= maxLength) {
        return text;
      }
      return "${text.substring(0, maxLength)}...";
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                value: isCompleted,
                onChanged: (value) => onToggle(),
                activeColor: kMainColor,
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 2.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            kSizedBoxWidth_5,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  truncateText(task.title, 25),
                  style: kMediumTextStyle(context),
                ),
                kSizedBoxHeight_5,
                task.dueDate != null && task.dueDate!.isNotEmpty
                    ? Row(
                        children: [
                          const Icon(
                            Iconsax.calendar5,
                            color: kMainColor,
                            size: 16.0,
                          ),
                          kSizedBoxWidth_5,
                          Text(
                            task.dueDate!,
                            style: kButtonAlertTextStyle(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

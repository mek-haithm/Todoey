import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todey/shared/widgets/my_snack_bar.dart';
import '../../../config/language/locale_controller.dart';
import '../../../config/notifications/notification_service.dart';
import '../../../shared/alerts/my_message.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_date_picker.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../models/task.dart';
import '../models/task_provider.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  const EditTaskScreen({
    super.key,
    required this.task,
  });

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _dueDateController.text = widget.task.dueDate ?? '';
    _loadCategoriesAndSetSelectedCategory();
  }

  Future<void> _loadCategoriesAndSetSelectedCategory() async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    await taskProvider.getCategoriesForTasks();

    setState(() {
      final category = taskProvider.categories.firstWhere(
        (cat) => cat['id'] == widget.task.categoryId,
        orElse: () => <String, dynamic>{},
      );
      _selectedCategory =
          category.isNotEmpty ? category['id'].toString() : null;
    });
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _dueDateController.text =
          DateFormat('yyyy/MM/dd - hh:mm a').format(selectedDate);
    });
    _titleFocusNode.unfocus();
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    if (kDebugMode) {
      print(now);
    }
    DateFormat formatter = DateFormat('yyyy/MM/dd - hh:mm a');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: kBackground,
        surfaceTintColor: Colors.transparent,
        title: Align(
          alignment: LocalController().isEnglish
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Text(
            "editTask".tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
        leading: IconButton(
          onPressed: () {
            MyMessage.showMyMessage(
              context: context,
              message: 'confirmDeleteTask'.tr,
              firstButton: 'cancel'.tr,
              onFirstButtonPressed: () {
                Navigator.pop(context);
              },
              secondButton: 'ok'.tr,
              onSecondButtonPressed: () {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(widget.task.id!);
                MySnackBar.showSnackBar(message: "taskDeleted".tr);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              isDismissible: false,
            );
          },
          icon: Icon(
            Iconsax.trash,
            color: Colors.red.shade900,
          ),
        ),
      ),
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MyTextField(
              hintText: 'taskTitle'.tr,
              controller: _titleController,
              focusNode: _titleFocusNode,
            ),
            kSizedBoxHeight_15,
            MyDatePicker(
              onDateSelected: _onDateSelected,
              dueDate: _dueDateController.text.isNotEmpty
                  ? _dueDateController.text
                  : 'dueDateOptional'.tr,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ),
            kSizedBoxHeight_15,
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                List<Map<String, dynamic>> categories = taskProvider.categories;

                return categories.isEmpty
                    ? DropdownButton<String>(
                        hint: Text(
                          'noCategories'.tr,
                          style: kInactiveTextStyle(context),
                        ),
                        value: null,
                        items: null,
                        onChanged: null,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        iconSize: 24,
                        underline: Container(
                          height: 2,
                          color: Colors.grey[300],
                        ),
                        style: kInactiveTextStyle(
                            context), // Optional, for consistency
                        dropdownColor: kBackground,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        borderRadius: BorderRadius.circular(15.0),
                      )
                    : DropdownButton<String>(
                        hint: Text(
                          'selectCategory'.tr,
                          style: kInactiveTextStyle(context),
                        ),
                        value: _selectedCategory,
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['id'].toString(),
                            child: Text(
                              category['category_name'] ?? '',
                              style: kMediumTextStyle(context),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                        iconSize: 24,
                        underline: Container(
                          height: 2,
                          color: Colors.grey[300],
                        ),
                        style: kMediumTextStyle(context),
                        dropdownColor: kBackground,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        borderRadius: BorderRadius.circular(15.0),
                      );
              },
            ),
            kSizedBoxHeight_25,
            MyButton(
              text: 'save'.tr,
              onPressed: () {
                final title = _titleController.text.trim();
                final dueDate = _dueDateController.text.trim();

                if (title.isEmpty) {
                  MyMessage.showWarningMessage(
                    context,
                    "emptyTaskTitle".tr,
                  );
                  return;
                }

                final createdAt = getFormattedDate();

                final updatedTask = Task(
                  id: widget.task.id!,
                  title: title,
                  createdAt: createdAt,
                  dueDate: dueDate.isNotEmpty ? dueDate : null,
                  categoryId: _selectedCategory != null
                      ? int.tryParse(_selectedCategory!)
                      : null,
                );

                Provider.of<TaskProvider>(context, listen: false).updateTask(updatedTask);

                if (dueDate.isNotEmpty) {
                  NotificationService.scheduleNotification(
                    id: widget.task.id ?? 0,
                    title: 'taskReminder'.tr,
                    body: '${'yourTask'.tr} "$title" ${'isDue'.tr}',
                    scheduledDateTime: DateFormat('yyyy/MM/dd - hh:mm a').parse(dueDate),
                  );
                }

                print(widget.task.id!);

                MySnackBar.showSnackBar(message: "taskUpdated".tr);
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}

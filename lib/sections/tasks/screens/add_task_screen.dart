import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todey/shared/alerts/my_message.dart';
import 'package:todey/shared/constants/sizes.dart';
import 'package:todey/shared/widgets/my_text_field.dart';
import 'package:todey/shared/widgets/my_button.dart';
import 'package:todey/shared/widgets/my_date_picker.dart';

import '../../../config/language/locale_controller.dart';
import '../../../config/notifications/notification_service.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/text_styles.dart';
import '../models/task.dart';
import '../models/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();

  DateTime? _dueDate;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _dueDateController.text = '';

    Provider.of<TaskProvider>(context, listen: false).getCategoriesForTasks();
  }

  void _onDateSelected(DateTime selectedDate) {
    setState(() {
      _dueDate = selectedDate;
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
            "addTask".tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
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
              dueDate: _dueDate == null || _dueDateController.text.isEmpty
                  ? 'dueDateOptional'.tr
                  : _dueDateController.text,
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
              text: 'addTask'.tr,
              onPressed: () {
                final title = _titleController.text.trim();

                if (title.isEmpty) {
                  MyMessage.showWarningMessage(
                    context,
                    "emptyTaskTitle".tr,
                  );
                  return;
                }

                final createdAt = getFormattedDate();

                final taskId =
                    DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF;

                final newTask = Task(
                  id: taskId,
                  title: title,
                  createdAt: createdAt,
                  dueDate: _dueDate != null
                      ? DateFormat('yyyy/MM/dd - hh:mm a').format(_dueDate!)
                      : '',
                  categoryId: _selectedCategory != null
                      ? int.tryParse(_selectedCategory!)
                      : null,
                );

                // Add the task to the provider
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(newTask);

                // Schedule the notification with the task ID
                if (_dueDate != null) {
                  NotificationService.scheduleNotification(
                    id: newTask.id!,
                    title: 'taskReminder'.tr,
                    body: '${'yourTask'.tr} "$title" ${'isDue'.tr}',
                    scheduledDateTime: _dueDate!,
                  );
                }
                if (kDebugMode) {
                  print(newTask.id);
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

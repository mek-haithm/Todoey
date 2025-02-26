import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todey/sections/categories/models/category_provider.dart';

import '../../../config/language/locale_controller.dart';
import '../../../config/notifications/notification_service.dart';
import '../../../shared/alerts/my_message.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../../../shared/widgets/my_button.dart';
import '../../../shared/widgets/my_date_picker.dart';
import '../../../shared/widgets/my_text_field.dart';
import '../../tasks/models/task.dart';
import '../../tasks/models/task_provider.dart';

class AddCategoryTasks extends StatefulWidget {
  final int categoryId;
  const AddCategoryTasks({
    super.key,
    required this.categoryId,
  });

  @override
  State<AddCategoryTasks> createState() => _AddCategoryTasksState();
}

class _AddCategoryTasksState extends State<AddCategoryTasks> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  final FocusNode _titleFocusNode = FocusNode();

  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _dueDateController.text = '';
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
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return Column(
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

                      if (_dueDate == null) {
                        MyMessage.showWarningMessage(
                          context,
                          "emptyDueDate".tr,
                        );
                        return;
                      }

                      final createdAt = getFormattedDate();

                      final taskId =
                          DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF;

                      final newTask = Task(
                        id: taskId, // Assign the truncated ID
                        title: title,
                        createdAt: createdAt,
                        dueDate: _dueDate != null
                            ? DateFormat('yyyy/MM/dd - hh:mm a')
                                .format(_dueDate!)
                            : '',
                        categoryId: widget.categoryId,
                      );

                      Provider.of<TaskProvider>(context, listen: false).addTask(
                        newTask,
                        categoryId: widget.categoryId,
                        categoryProvider: categoryProvider,
                      );

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
              );
            },
          )),
    );
  }
}

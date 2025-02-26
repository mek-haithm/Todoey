import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:todey/sections/categories/screens/add_category_tasks.dart';
import 'package:todey/sections/categories/screens/edit_category_tasks.dart';
import 'package:todey/shared/alerts/my_message.dart';
import '../../../config/language/locale_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../../../shared/widgets/my_snack_bar.dart';
import '../../tasks/models/task_provider.dart';
import '../../tasks/widgets/task_tile.dart';
import '../models/category_provider.dart';

class CategoryTasks extends StatefulWidget {
  final int categoryId;
  final String name;
  const CategoryTasks({
    super.key,
    required this.categoryId,
    required this.name,
  });

  @override
  State<CategoryTasks> createState() => _CategoryTasksState();
}

class _CategoryTasksState extends State<CategoryTasks> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchCategoryTasks(
      widget.categoryId,
    );
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
            widget.name.tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
        leading: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
          return IconButton(
            onPressed: () {
              MyMessage.showMyMessage(
                context: context,
                message: 'confirmDeleteCategory'.tr,
                firstButton: 'cancel'.tr,
                onFirstButtonPressed: () {
                  Navigator.pop(context);
                },
                secondButton: 'ok'.tr,
                onSecondButtonPressed: () {
                  categoryProvider.deleteCategory(widget.categoryId);
                  MySnackBar.showSnackBar(message: 'categoryDeleted'.tr);
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
          );
        }),
      ),
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final todoTasks = taskProvider.categoryTasks
                .where((t) => !t.isCompleted)
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategoryTasks(
                          categoryId: widget.categoryId,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "addTask".tr,
                          style: kButtonTextStyle(context).copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Icon(
                          Icons.add_circle_outlined,
                          color: kMainColor,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
                if (todoTasks.isNotEmpty) ...[
                  kSizedBoxHeight_10,
                  Divider(color: Colors.grey.shade300),
                  kSizedBoxHeight_10,
                  Text(
                    "todo".tr,
                    style: kInactiveBoldTextStyle(context),
                  ),
                  kSizedBoxHeight_10,
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(5.0),
                      itemCount: todoTasks.length,
                      separatorBuilder: (_, __) => kSizedBoxHeight_15,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditCategoryTasks(
                                  task: todoTasks[index],
                                ),
                              ),
                            );
                          },
                          task: todoTasks[index],
                          onToggle: () {
                            final categoryProvider =
                                Provider.of<CategoryProvider>(context,
                                    listen: false);
                            taskProvider.toggleCategoryTaskCompletion(
                              todoTasks[index].id!,
                              categoryProvider: categoryProvider,
                            );
                            MySnackBar.showSnackBar(
                                message: "taskCompleted".tr);
                          },
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.task,
                          size: 50.0,
                          color: Colors.grey.shade500,
                        ),
                        kSizedBoxHeight_10,
                        Text(
                          "nothingToDo".tr,
                          style: kInactiveBoldTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

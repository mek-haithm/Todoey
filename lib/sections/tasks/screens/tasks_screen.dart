import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:todey/sections/categories/screens/categories_screen.dart';
import 'package:todey/sections/settings/screens/settings_screen.dart';
import 'package:todey/sections/tasks/screens/completed_tasks_screen.dart';
import 'package:todey/sections/tasks/screens/edit_task_screen.dart';
import 'package:todey/sections/tasks/widgets/task_tile.dart';
import 'package:todey/shared/constants/sizes.dart';
import 'package:todey/shared/constants/text_styles.dart';
import 'package:todey/shared/widgets/my_snack_bar.dart';
import '../../../config/language/locale_controller.dart';
import '../../../shared/constants/colors.dart';
import '../models/task_provider.dart';
import 'add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
            "allTasks".tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Iconsax.menu_1,
            color: kMainColor,
          ),
        ),
      ),
      backgroundColor: kBackground,
      drawer: Drawer(
        backgroundColor: kMainColorDark,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: kMainColorDark,
              ),
              child: Center(
                child: Text(
                  'todo_list'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ibmFont",
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Iconsax.settings,
                color: kBackground,
              ),
              title: Text(
                'settings'.tr,
                style: kButtonTextStyle(context),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Iconsax.category,
                color: kBackground,
              ),
              title: Text(
                'categories'.tr,
                style: kButtonTextStyle(context),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Iconsax.tick_circle,
                color: kBackground,
              ),
              title: Text(
                'completedTasks'.tr,
                style: kButtonTextStyle(context),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CompletedTasksScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final todoTasks =
                taskProvider.tasks.where((t) => !t.isCompleted).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTaskScreen(),
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
                                builder: (context) => EditTaskScreen(
                                  task: todoTasks[index],
                                ),
                              ),
                            );
                          },
                          task: todoTasks[index],
                          onToggle: () {
                            taskProvider
                                .toggleTaskCompletion(todoTasks[index].id!);
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

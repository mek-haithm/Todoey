import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../models/task_provider.dart';
import '../widgets/task_tile.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
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
          alignment: Alignment.centerRight,
          child: Text(
            "completedTasks".tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
      ),
      backgroundColor: kBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            final completedTasks =
                taskProvider.tasks.where((t) => t.isCompleted).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (completedTasks.isNotEmpty) ...[
                kSizedBoxHeight_10,
                Divider(color: Colors.grey.shade300),
                kSizedBoxHeight_10,
                  Text(
                    "completed".tr,
                    style: kInactiveBoldTextStyle(context),
                  ),
                  kSizedBoxHeight_10,
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(5.0),
                      itemCount: completedTasks.length,
                      separatorBuilder: (_, __) => kSizedBoxHeight_15,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          task: completedTasks[index],
                          isCompleted: true,
                          onToggle: () {
                            taskProvider.toggleTaskCompletion(
                                completedTasks[index].id!);
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
                          Iconsax.folder_2,
                          size: 50.0,
                          color: Colors.grey.shade500,
                        ),
                        kSizedBoxHeight_10,
                        Text(
                          "noCompletedTasks".tr,
                          style: kInactiveBoldTextStyle(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:todey/sections/categories/models/category_model.dart';
import 'package:todey/sections/categories/models/category_provider.dart';
import 'package:todey/sections/categories/screens/category_tasks.dart';
import 'package:todey/shared/widgets/my_snack_bar.dart';
import '../../../config/language/locale_controller.dart';
import '../../../shared/alerts/my_dialog.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../widgets/category_box.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    super.initState();
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
            "categories".tr,
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
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, child) {
            final categories = categoryProvider.categories.toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return MyDialog(
                          title: 'addCategory'.tr,
                          hint: 'addCategory'.tr,
                          controller: categoryController,
                          firstButton: 'cancel'.tr,
                          secondButton: 'ok'.tr,
                          onFirstButtonPressed: () {
                            Navigator.pop(context);
                          },
                          onSecondButtonPressed: () {
                            CategoryModel category = CategoryModel(
                              categoryName: categoryController.text,
                              createdAt: DateTime.now().toString(),
                            );
                            if (categoryController.text.isEmpty ||
                                categoryController.text == '') {
                              MySnackBar.showSnackBar(
                                  message: 'emptyCategoryTitle'.tr);
                            } else {
                              categoryProvider.addCategory(category);
                              MySnackBar.showSnackBar(
                                  message: 'categoryAdded'.tr);
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      },
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
                          "addCategory".tr,
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
                if (categories.isNotEmpty) ...[
                  kSizedBoxHeight_10,
                  Divider(color: Colors.grey.shade300),
                  kSizedBoxHeight_10,
                  Text(
                    "categories".tr,
                    style: kInactiveBoldTextStyle(context),
                  ),
                  kSizedBoxHeight_10,
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(5.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryBox(
                          name: category.categoryName,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryTasks(
                                  categoryId: category.id!,
                                  name: category.categoryName,
                                ),
                              ),
                            );
                          },
                          count: categoryProvider.getTaskCount(category.id!),
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
                          Iconsax.category,
                          size: 50.0,
                          color: Colors.grey.shade500,
                        ),
                        kSizedBoxHeight_10,
                        Text(
                          "noCategories".tr,
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

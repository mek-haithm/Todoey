import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todey/sections/categories/models/category_provider.dart';
import 'package:todey/sections/splash/splash_screen.dart';
import 'package:todey/sections/tasks/models/task_provider.dart';
import 'config/language/locale.dart';
import 'config/language/locale_controller.dart';
import 'config/notifications/notification_service.dart';

SharedPreferences? sharedPref;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeNotification();
  sharedPref = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: controller.initialLang,
      translations: MyLocale(),
      home: const SplashScreen(),
    );
  }
}
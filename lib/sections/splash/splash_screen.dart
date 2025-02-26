import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../tasks/screens/tasks_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  TasksScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          kSizedBoxHeight_5,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo light.png',
                  width: 100.0,
                ),
              ),
              kSizedBoxHeight_15,
              Text(
                'todolist'.tr,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: kMainColor,
                  fontFamily: 'ibmFont',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          Column(
            children: [
              Text(
                'todolistApp'.tr,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                  fontFamily: 'ibmFont',
                ),
              ),
              kSizedBoxHeight_30,
            ],
          )
        ],
      ),
    );
  }
}

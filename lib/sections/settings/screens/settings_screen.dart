import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../config/language/locale_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_styles.dart';
import '../../../shared/widgets/language_popup.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
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
            "settings".tr,
          ),
        ),
        titleTextStyle: kInactiveBoldTextStyle(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
        ),
        child: Column(
          children: [
            kSizedBoxHeight_20,
            Align(
              alignment: LocalController().isEnglish
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Text(
                'language'.tr,
                style: kInactiveTextStyle(context),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
            ListTile(
              splashColor: Colors.transparent,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const LanguagePopup(),
                );
              },
              leading: const Icon(
                Iconsax.language_circle,
                color: kMainColor,
              ),
              title: Text(
                'language'.tr,
                style: kMediumTextStyle(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

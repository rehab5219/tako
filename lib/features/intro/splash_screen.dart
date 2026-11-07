import 'package:flutter/material.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/functions/navigation.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/features/intro/onboarding/onboarding_view.dart';
import 'package:tako/service/local/local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AppLocalStorage.init();
    Future.delayed(const Duration(seconds: 3), () {
      pushAndRemoveUntil(context, const OnboardingView());
      // bool isOnboardingShown =
      //     AppLocalStorage.getData(key: AppLocalStorage.isOnboardingShown) ?? false;
      // bool hasSeenWelcome =
      //     AppLocalStorage.getData(key: AppLocalStorage.hasSeenWelcome) ?? false;
      // bool isLoggedIn =
      //     AppLocalStorage.getData(key: AppLocalStorage.isLoggedIn) ?? false;
      // String? userType =
      //     AppLocalStorage.getData(key: AppLocalStorage.userType).toString();
      // if (!isOnboardingShown) {
      //   pushAndRemoveUntil(context, const OnboardingView());
      // } else if (!hasSeenWelcome) {
      //   pushAndRemoveUntil(context, const WelcomeScreen());
      // } else if (isLoggedIn) {
      //   if (userType == 'teacher') {
      //     pushAndRemoveUntil(context, const TeacherNavBarScreen());
      //   } else if (userType == 'student') {
      //     pushAndRemoveUntil(context, const StudentNavBarScreen()); 
      //   } else {
      //     pushAndRemoveUntil(context, const WelcomeScreen());
      //   }
      // } else {
      //   pushAndRemoveUntil(context, const WelcomeScreen());
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsManager.logo,
                width: double.infinity, height: 783, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}

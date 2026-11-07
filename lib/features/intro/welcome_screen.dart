import 'package:flutter/material.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/functions/navigation.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/features/auth/presentation/view/login_screen.dart';
import 'package:tako/features/auth/presentation/view/sign_up_screen.dart';
import '../../core/utils/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            AssetsManager.account,
            width: 750,
            height: 750,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Title
                      Text(
                        'Start Now',
                        style: getHeadTextStyle().copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                push(context, const SignUpScreen());
                              },
                              style: ElevatedButton.styleFrom(

                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                'Sign Up',
                                style: getHeadTextStyle().copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                push(context, const LoginScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                'Login',
                                style: getHeadTextStyle().copyWith(
                                  color: AppColors.secondaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

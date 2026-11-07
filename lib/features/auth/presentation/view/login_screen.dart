import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/functions/navigation.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/core/widgets/custom_botton.dart';
import 'package:tako/features/auth/presentation/view/sign_up_screen.dart';
import 'package:tako/features/home/presentation/view/skill_feed_screen.dart';
import 'package:tako/features/nav%20bar/button_nav_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = false;

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          SafeArea(
            child: Image.asset(
              AssetsManager.login,
              width: 450,
              height: 450,
              fit: BoxFit.cover,
            ),
          ),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          Text(
                            'LogIn',
                            style: getHeadTextStyle().copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: email,
                            cursorColor: AppColors.primaryColor,
                            style: getSmallTextStyle(),
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: getBodyTextStyle(),
                              label: Text('Email', style: getSmallTextStyle()),
                              prefixIcon: const Icon(
                                Iconsax.sms5,
                                color: AppColors.primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.redColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please, enter your email";
                              } else if (!RegExp(
                                r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$",
                              ).hasMatch(value)) {
                                return "please, enter valid email";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: password,
                            cursorColor: AppColors.primaryColor,
                            style: getSmallTextStyle(),
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: getBodyTextStyle(),
                              label: Text(
                                'Password',
                                style: getSmallTextStyle(),
                              ),
                              prefixIcon: const Icon(
                                Iconsax.lock5,
                                color: AppColors.primaryColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  (isVisible)
                                      ? Iconsax.eye_slash5
                                      : Iconsax.eye4,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.redColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            obscureText: isVisible,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "please, enter your password";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          CustomButton(
                            fgColor: AppColors.secondaryColor,
                            text: 'LogIn',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final credential = await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text,
                                      );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (credential.user != null) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => ButtonNavBar(),
                                      ),
                                    );
                                  }
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (e.code == 'user-not-found') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "user-not-found",
                                          style: getSmallTextStyle(
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (e.code == 'wrong-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "wrong-password",
                                          style: getSmallTextStyle(
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "Don't have an account?",
                                style: getSmallTextStyle(),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    pushReplacement(context, SignUpScreen());
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: getSmallTextStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

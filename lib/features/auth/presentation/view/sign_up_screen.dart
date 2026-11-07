import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/functions/navigation.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/core/widgets/custom_botton.dart';
import 'package:tako/features/auth/presentation/view/login_screen.dart';
import 'package:tako/features/auth/presentation/view/skills_registration_view.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            AssetsManager.signUp,
            width: 450,
            height: 450,
            fit: BoxFit.cover,
          ),
          Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            'Sign Up',
                            style: getHeadTextStyle().copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: firstName,
                            cursorColor: AppColors.primaryColor,
                            style: getSmallTextStyle(),
                            decoration: InputDecoration(
                              hintText: "First Name",
                              hintStyle: getBodyTextStyle(),
                              label: Text(
                                'First Name',
                                style: getSmallTextStyle(),
                              ),
                              prefixIcon: Icon(
                                Iconsax.profile_circle5,
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
                                return "please, enter your first name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: secondName,
                            cursorColor: AppColors.primaryColor,
                            style: getSmallTextStyle(),
                            decoration: InputDecoration(
                              hintText: "Second Name",
                              hintStyle: getBodyTextStyle(),
                              label: Text(
                                'Second Name',
                                style: getSmallTextStyle(),
                              ),
                              prefixIcon: const Icon(
                                Iconsax.profile_circle5,
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
                                return "please, enter your second name";
                              } else {
                                return null;
                              }
                            },
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
                            text: 'Sign Up',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text,
                                      );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder:
                                          (context) => SkillsRegistrationView(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "The password provided is too weak.",
                                          style: getSmallTextStyle(
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (e.code == 'email-already-in-use') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.primaryColor,
                                        content: Text(
                                          "The account already exists",
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I have an account?",
                                style: getSmallTextStyle(),
                              ),
                              TextButton(
                                onPressed: () {
                                  pushReplacement(context, LoginScreen());
                                },
                                child: Text(
                                  "LogIn",
                                  style: getSmallTextStyle(
                                    color: AppColors.primaryColor,
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

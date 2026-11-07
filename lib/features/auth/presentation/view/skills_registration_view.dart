import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/features/nav%20bar/button_nav_bar.dart';

class SkillsRegistrationView extends StatefulWidget {
  @override
  _SkillsRegistrationViewState createState() => _SkillsRegistrationViewState();
}

class _SkillsRegistrationViewState extends State<SkillsRegistrationView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _availabilityWeekdaysController =
      TextEditingController();
  final TextEditingController _availabilityWeekendsController =
      TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  final List<String> skills = [
    'Gardening',
    'Plumbing',
    'Electrical fixing',
    'Cleaning',
    'Car repair',
    'Moving / carrying items',
    'Babysitting',
    'Pet care (walking, feeding, grooming)',
    'Shopping for groceries',
    'Cooking / meal prep',
    'Language learning (English, Arabic, French, etc.)',
    'Subject tutoring',
    'Programming / coding help',
    'Music lessons (guitar, piano, etc.)',
    'Art / drawing / design',
    'Graphic design',
    'Video editing',
    'Photo editing',
    'Social media help',
    'Tech support (phones, laptops, Wi-Fi)',
    'Website creation',
    'App development',
    'Companionship / visiting elderly neighbors',
    'Emotional support / listening',
    'Running errands',
    'Writing letters / documents',
    'Helping with forms / applications',
  ];

  List<String> selectedSkills = [];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              AssetsManager.feed,
              width: 800,
              height: 800,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 25,
            child: Text(
              'Complete Registration',
              style: getHeadTextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle(color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: getSmallTextStyle(
                          color: AppColors.secondaryColor,
                        ),
                        prefixIcon: Icon(Iconsax.user),
                        prefixIconColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator:
                          (value) =>
                              value!.isEmpty ? "Please enter your name" : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _locationController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle(color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        labelText: "Location",
                        labelStyle: getSmallTextStyle(
                          color: AppColors.secondaryColor,
                        ),
                        prefixIcon: Icon(Iconsax.location),
                        prefixIconColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator:
                          (value) =>
                              value!.isEmpty
                                  ? "Please enter your location"
                                  : null,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _aboutController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle(color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        labelText: "About",
                        labelStyle: getSmallTextStyle(
                          color: AppColors.secondaryColor,
                        ),
                        prefixIcon: Icon(Iconsax.info_circle),
                        prefixIconColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Skills & Services",
                      style: getSmallTextStyle(
                        color: AppColors.secondaryColor,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children:
                          skills.map((skill) {
                            final isSelected = selectedSkills.contains(skill);
                            return ChoiceChip(
                              label: Text(skill),
                              selected: isSelected,
                              selectedColor: AppColors.primaryColor,
                              backgroundColor: AppColors.secondaryColor,
                              labelStyle: getSmallTextStyle(
                                color:
                                    isSelected
                                        ? AppColors.secondaryColor
                                        : AppColors.primaryColor,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedSkills.add(skill);
                                  } else {
                                    selectedSkills.remove(skill);
                                  }
                                });
                              },
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Availability",
                      style: getSmallTextStyle(
                        color: AppColors.secondaryColor,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _availabilityWeekdaysController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle(color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        labelText: "Weekdays (e.g. 6PM - 9PM)",
                        labelStyle: getSmallTextStyle(
                          color: AppColors.secondaryColor,
                        ),
                        prefixIcon: Icon(Iconsax.clock),
                        prefixIconColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _availabilityWeekendsController,
                      cursorColor: AppColors.secondaryColor,
                      style: getSmallTextStyle(color: AppColors.secondaryColor),
                      decoration: InputDecoration(
                        labelText: "Weekends (e.g. 9AM - 6PM)",
                        labelStyle: getSmallTextStyle(
                          color: AppColors.secondaryColor,
                        ),
                        prefixIcon: Icon(Iconsax.clock),
                        prefixIconColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: isLoading ? null : _saveProfile,
                        child:
                            isLoading
                                ? CircularProgressIndicator(color: AppColors.primaryColor)
                                : Text(
                                  "Save Profile",
                                  style: getBodyTextStyle().copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
      "name": _nameController.text,
      "location": _locationController.text,
      "about": _aboutController.text,
      "additionalInfo": _additionalInfoController.text,
      "skills": selectedSkills,
      "availability": {
        "weekdays": _availabilityWeekdaysController.text,
        "weekends": _availabilityWeekendsController.text,
      },
      "createdAt": FieldValue.serverTimestamp(),
      "requestsCompleted": 0,
      "averageRating": 0.0,
      "responseTime": "<2hrs",
      "memberSince": DateTime.now().year,
    });

    setState(() => isLoading = false);

    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (context) => ButtonNavBar()));
  }
}

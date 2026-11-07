import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/core/widgets/custom_botton.dart';
import 'package:tako/core/widgets/week_text_form_field.dart';
import 'package:tako/features/home/models/help_post.dart';

class PostHelpScreen extends StatefulWidget {
  const PostHelpScreen({super.key});

  @override
  State<PostHelpScreen> createState() => _PostHelpScreenState();
}

class _PostHelpScreenState extends State<PostHelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _imagePath;
  File? file;
  String? profileUrl;

  String? userID;
  String? userName;
  String? userProfileImageUrl;
  String? description;
  String? skill;
  String? location;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _skillController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        userID = currentUser.uid;
      });
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc['userName'];
          userProfileImageUrl = userDoc['userProfileImageUrl'];
        });
      } else {}
    } else {}
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        file = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      try {
        // 1. Get current user ID (assuming you have a way to do this)
        final userId = FirebaseAuth.instance.currentUser!.uid;

        // 2. Create a Map with the post data
        final newPost = HelpPost(
          id: '',
          userId: userID ?? '',
          userName: _usernameController.text.trim(),
          userProfileImageUrl: userProfileImageUrl ?? AssetsManager.logo,
          description: _descriptionController.text.trim(),
          category: _categoryController.text.trim(),
          location: _locationController.text.trim(),
          distance: 0.0,
          rating: 0.0,
          postDate: DateTime.now(),
          time: null,
        );

        _usernameController.clear();
        _skillController.clear();
        _descriptionController.clear();
        _categoryController.clear();
        _locationController.clear();

        // 3. Add the data to Firestore
        await FirebaseFirestore.instance
            .collection('help_posts')
            .add(newPost.toFirestore());

        // 4. Show a success message and navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post submitted successfully!')),
        ); // Navigator.pop(context); // Go back to the previous screen (home feed)
      } catch (e) {
        print('Error submitting post: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to submit post.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              AssetsManager.feed, // Ensure this asset exists
              width: 800,
              height: 800,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 300,
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
            top: 250,
            left: 25,
            child: Text(
              'Add Help',
              style: getHeadTextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 300, left: 25, right: 25),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                (file != null)
                                    ? FileImage(file!)
                                    : (userProfileImageUrl != null &&
                                            userProfileImageUrl!.isNotEmpty
                                        ? NetworkImage(userProfileImageUrl!)
                                            as ImageProvider
                                        : const AssetImage(AssetsManager.logo)),
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: Icon(
                              Iconsax.camera,
                              color: AppColors.primaryColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    WeekTextFormField(
                      color: AppColors.secondaryColor,
                      hintText: 'UserName',
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WeekTextFormField(
                      color: AppColors.secondaryColor,
                      hintText: 'Description',
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WeekTextFormField(
                      color: AppColors.secondaryColor,
                      hintText: 'Category',
                      controller: _categoryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    WeekTextFormField(
                      color: AppColors.secondaryColor,
                      hintText: 'Location',
                      controller: _locationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      text: 'Submit Post',
                      onPressed: _submitPost,
                      bgColor: AppColors.secondaryColor,
                      fgColor: AppColors.primaryColor,
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
}

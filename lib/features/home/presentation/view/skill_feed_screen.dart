import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/features/home/presentation/view/post_help.dart';
import 'package:tako/features/home/presentation/widgets/skill_card.dart';

class SkillFeedScreen extends StatefulWidget {
  const SkillFeedScreen({super.key});

  @override
  State<SkillFeedScreen> createState() => _SkillFeedScreenState();
}

class _SkillFeedScreenState extends State<SkillFeedScreen> {
  final skillFeed =
      FirebaseFirestore.instance.collection('skill_posts').snapshots();
  final postHelp =
      FirebaseFirestore.instance.collection('help_posts').snapshots();

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
            height: 250,
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
            top: 200,
            left: 25,
            child: Text(
              'Help Feed',
              style: getHeadTextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
          ),

          /// Merge two streams manually
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: StreamBuilder<QuerySnapshot>(
              stream: skillFeed,
              builder: (context, skillSnapshot) {
                return StreamBuilder<QuerySnapshot>(
                  stream: postHelp,
                  builder: (context, helpSnapshot) {
                    if (!skillSnapshot.hasData || !helpSnapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.secondaryColor,
                        ),
                      );
                    }

                    // Merge documents
                    final allDocs = [
                      ...skillSnapshot.data!.docs,
                      ...helpSnapshot.data!.docs,
                    ];

                    // Sort by postDate
                    allDocs.sort((a, b) {
                      final aDate = a['postDate'] as Timestamp;
                      final bDate = b['postDate'] as Timestamp;
                      return bDate.compareTo(aDate);
                    });

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: allDocs.length,
                      itemBuilder: (context, index) {
                        var data = allDocs[index].data() as Map<String, dynamic>;

                        return SkillCard(
                          name: data['userName'] ?? '',
                          distance: data['distance']?.toString() ?? '',
                          rating: (data['rating'] is int)
                              ? (data['rating'] as int).toDouble()
                              : (data['rating'] ?? 0.0),
                          skill: data['skill'] ?? data['helpTitle'] ?? '',
                          description:
                              data['description'] ?? data['helpDescription'] ?? '',
                          location: data['location'] ?? '',
                          category: data['category'] ?? '',
                          postDate: data['postDate'].toDate().toString(),
                          userProfileImageUrl: data['userProfileImageUrl'] ?? '',
                          time: data['time'] ?? '',
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),

          Positioned(
            bottom: 80,
            right: 25,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Post Help',
                style: getBodyTextStyle().copyWith(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PostHelpScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tako/core/constants/assets_manager.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';

class SkillCard extends StatelessWidget {
  final String name;
  final String distance;
  final double rating;
  final String skill;
  final String description;
  final String location;
  final String category;
  final String userProfileImageUrl;
  final String postDate;
  final String time;
  final bool isSkillPost; // NEW FIELD

  const SkillCard({
    super.key,
    required this.name,
    required this.distance,
    required this.rating,
    required this.skill,
    required this.category,
    required this.time,
    required this.description,
    required this.location,
    required this.userProfileImageUrl,
    required this.postDate,
    this.isSkillPost = true, // default is skill post
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryColor,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      userProfileImageUrl.isNotEmpty
                          ? NetworkImage(userProfileImageUrl)
                          : const AssetImage(AssetsManager.logo)
                              as ImageProvider,
                  radius: 22,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getSmallTextStyle().copyWith(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$distance km away',
                      style: getSmallTextStyle().copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 16,
                          color:
                              index < rating.round()
                                  ? AppColors.secondaryColor
                                  : AppColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Skill (only if skill post)
            if (isSkillPost && skill.isNotEmpty) ...[
              Text(
                '🛠️ Skill: $skill',
                style: getSmallTextStyle().copyWith(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
            ],

            // Description
            Text(
              '📝 $description',
              style: getSmallTextStyle().copyWith(
                color: AppColors.secondaryColor,
              ),
            ),

            const SizedBox(height: 6),

            // Location & Time
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: getSmallTextStyle().copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                if (time.isNotEmpty) ...[
                  const Text(" • "),
                  Text(
                    time,
                    style: getSmallTextStyle().copyWith(
                      color: AppColors.secondaryColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 6),

            // Category & Post Date
            Row(
              children: [
                const Icon(Icons.category, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  category,
                  style: getSmallTextStyle().copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                if (postDate.isNotEmpty) ...[
                  const Text(" • "),
                  Text(
                    postDate,
                    style: getSmallTextStyle().copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.message,
                      color: AppColors.primaryColor,
                    ),
                    label: Text(
                      "Message",
                      style: getSmallTextStyle().copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.volunteer_activism,
                      color: AppColors.primaryColor,
                    ),
                    label: Text(
                      "Offer Help",
                      style: getSmallTextStyle().copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

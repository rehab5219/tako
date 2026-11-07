import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/features/auth/presentation/view/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection("users").doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No profile data found"));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(data),
                const SizedBox(height: 16),
                _buildStatsGrid(data),
                const SizedBox(height: 16),
                _buildActionButtons(),
                const SizedBox(height: 16),
                _buildDetailedSections(data),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Log out',
                    style: getBodyTextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Iconsax.edit, color: AppColors.secondaryColor),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryColor,
                child: Text(
                  data['name'] != null && data['name'].isNotEmpty
                      ? data['name'] + data['name'].split(" ").last
                      : "U",
                  style: getTitleTextStyle().copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data['location'] ?? '',
                        style: getSmallTextStyle().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${data['rating']} (${data['reviewsCount']} reviews)",
                        style: getSmallTextStyle().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
        children: [
          _buildStatCard(
            'REQUESTS COMPLETED',
            data['completedRequests'].toString(),
          ),
          _buildStatCard(
            'AVERAGE RATING',
            data['rating'].toString(),
            icon: Iconsax.star,
          ),
          _buildStatCard(
            'RESPONSE TIME',
            data['responseTime'],
            icon: Iconsax.clock,
          ),
          _buildStatCard(
            'MEMBER SINCE',
            data['memberSince'].toString(),
            icon: Iconsax.verify,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, {IconData? icon}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon, color: AppColors.primaryColor, size: 20),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: getSmallTextStyle().copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: getSmallTextStyle().copyWith(
                color: AppColors.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primaryColor,
              ),
              label: const Text('Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: getSmallTextStyle(),
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mail),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSections(Map<String, dynamic> data) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            color: AppColors.secondaryColor,
            child: const TabBar(
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: AppColors.primaryColor,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Activity'),
                Tab(text: 'Reviews'),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(20),
            child: TabBarView(
              children: [
                _OverviewTab(data: data),
                const Center(child: Text('Activity Tab Content')),
                const Center(child: Text('Reviews Tab Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  final Map<String, dynamic> data;
  const _OverviewTab({required this.data});

  @override
  Widget build(BuildContext context) {
    final skills = (data['skills'] as List<dynamic>? ?? []).cast<String>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About'),
        const SizedBox(height: 8),
        Text(
          data['about'] ?? '',
          style: getSmallTextStyle().copyWith(color: AppColors.secondaryColor),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('Skills & Services'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => _buildSkillChip(skill)).toList(),
        ),
        const SizedBox(height: 20),
        _buildSectionTitle('Availability'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(
              'Weekdays',
              style: getSmallTextStyle(color: AppColors.secondaryColor),
            ),
            Text(
              data['availability']['weekdays'] ?? '',
              style: getSmallTextStyle(color: AppColors.secondaryColor),
            ),
            Text(
              'Weekends',
              style: getSmallTextStyle(color: AppColors.secondaryColor),
            ),
            Text(
              data['availability']['weekends'] ?? '',
              style: getSmallTextStyle(color: AppColors.secondaryColor),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color:
                    data['isAvailableNow'] == true
                        ? AppColors.primaryColor
                        : Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              data['isAvailableNow'] == true
                  ? 'Available Now'
                  : 'Not Available',
              style: getSmallTextStyle().copyWith(
                color: AppColors.secondaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getSmallTextStyle().copyWith(
        fontSize: 18,
        color: AppColors.secondaryColor,
      ),
    );
  }

  Widget _buildSkillChip(String text) {
    return Chip(
      label: Text(text),
      labelStyle: getSmallTextStyle().copyWith(color: AppColors.primaryColor),
      backgroundColor: AppColors.primaryColor.withAlpha(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}

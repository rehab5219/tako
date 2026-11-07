import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/features/add%20skill/presentation/view/add_skill_screen.dart';
import 'package:tako/features/chat/presentation/view/chat_screen.dart';
import 'package:tako/features/explore/presentation/view/explore_screen.dart';
import 'package:tako/features/home/presentation/view/skill_feed_screen.dart';
import 'package:tako/features/profile/presentation/view/profile_screen.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _ButtonNavBarState();
}

class _ButtonNavBarState extends State<ButtonNavBar> {
  final List<Widget> bottomBarPages = [
    SkillFeedScreen(),
    AddSkillScreen(),
    ExploreScreen(),
    CommunityChatScreen(),
    ProfileScreen(),
  ];

  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          bottomBarPages.length,
          (index) => bottomBarPages[index],
        ),
      ),
      extendBody: true,
      bottomNavigationBar:
          (bottomBarPages.length <= maxCount)
              ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                color: AppColors.secondaryColor,
                showLabel: false,
                textOverflow: TextOverflow.visible,
                maxLine: 1,
                shadowElevation: 5,
                kBottomRadius: 28.0,
                notchColor: AppColors.secondaryColor,
                removeMargins: false,
                bottomBarWidth: 500,
                showShadow: false,
                durationInMilliSeconds: 300,
                elevation: 1,
                bottomBarItems: const [
                  BottomBarItem(
                    inActiveItem: Icon(
                      Iconsax.home_2,
                      color: AppColors.primaryColor,
                    ),
                    activeItem: Icon(
                      Iconsax.home_21,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Iconsax.add_square,
                      color: AppColors.primaryColor,
                    ),
                    activeItem: Icon(
                      Iconsax.add_square5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Iconsax.search_normal,
                      color: AppColors.primaryColor,
                    ),
                    activeItem: Icon(
                      Iconsax.search_normal5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Iconsax.message_text,
                      color: AppColors.primaryColor,
                    ),
                    activeItem: Icon(
                      Iconsax.message_text_15,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(
                      Iconsax.profile_circle,
                      color: AppColors.primaryColor,
                    ),
                    activeItem: Icon(
                      Iconsax.profile_circle5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
                kIconSize: 24.0,
              )
              : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tako/core/functions/navigation.dart';
import 'package:tako/core/utils/app_colors.dart';
import 'package:tako/core/utils/styles.dart';
import 'package:tako/core/widgets/custom_botton.dart';
import 'package:tako/features/intro/onboarding/onboarding_model.dart';
import 'package:tako/features/intro/welcome_screen.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: PageView.builder(
          controller: pageController,
          itemCount: pages.length,
          onPageChanged: (value) {
            setState(() => currentPage = value);
          },
          itemBuilder: (context, index) {
            return Stack(
              children: [
                // Background illustration
                Image.asset(
                  pages[index].image,
                  width: 600,
                  height: 600,
                  fit: BoxFit.cover,
                ),

                // Top Bar (Back + Skip)
                Positioned(
                  top: 20,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentPage > 0)
                        GestureDetector(
                          onTap:
                              () => pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                          child: Icon(
                                Iconsax.arrow_left,
                                size: 26,
                                color: AppColors.secondaryColor,
                              ),
                        )
                      else
                        const SizedBox(width: 24), // Placeholder for alignment

                      TextButton(
                        onPressed:
                            () => pageController.jumpToPage(pages.length - 1),
                        child: Text(
                          'Skip',
                          style: getTitleTextStyle().copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom White Card with Content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          pages[index].title,
                          textAlign: TextAlign.center,
                          style: getHeadTextStyle().copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 12),

                        // Body
                        Text(
                          pages[index].body,
                          textAlign: TextAlign.center,
                          style: getTitleTextStyle().copyWith(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),

                        SizedBox(height: 24),

                        // SmoothPageIndicator
                        SmoothPageIndicator(
                          controller: pageController,
                          count: pages.length,
                          effect: ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 10,
                            activeDotColor: AppColors.primaryColor,
                            dotColor: AppColors.greyColor,
                            spacing: 8,
                          ),
                        ),

                        SizedBox(height: 24),

                        // Button (only on last page)
                        if (currentPage == pages.length - 1)
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: CustomButton(
                              height: 50,
                              width: double.infinity,
                              bgColor: AppColors.primaryColor,
                              fgColor: AppColors.secondaryColor,
                              text: "Let's Start!",
                              onPressed: () {
                                pushAndRemoveUntil(
                                  context,
                                  const WelcomeScreen(),
                                );
                              },
                            ),
                          )
                        else
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed:
                                  () => pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                              icon: Icon(
                                Iconsax.arrow_right_3,
                                size: 26,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

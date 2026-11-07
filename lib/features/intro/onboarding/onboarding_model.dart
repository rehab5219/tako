
class OnboardingModel {
  final String image;
  final String title;
  final String body;

  
  OnboardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List <OnboardingModel> pages = [
    OnboardingModel(
      image: 'assets/images/Welcome.png',
      title: 'Welcome to Tako',
      body: 'Exchange skills. Learn freely. Teach others.',
    ),
    OnboardingModel(
      image: 'assets/images/Take Away.png',
      title: 'Take & Offer',
      body: 'List what you can offer and what you want to learn.',
    ),
    OnboardingModel(
      image: 'assets/images/Online world.png',
      title: 'Connect with Neighbors',
      body: 'Find matches and grow together.',
    ),
    OnboardingModel(
      image: 'assets/images/Online Review.png',
      title: 'Verified & Rated',
      body: 'Build trust through community ratings and verified skills.',
    ),
    OnboardingModel(
      image: 'assets/images/Skills.png',
      title: 'Mutual Matches',
      body: 'We match you with people who want what you offer.',
    ),
    OnboardingModel(
      image: 'assets/images/Schedule.png',
      title: 'Schedule & Exchange',
      body: 'Agree on a time, meet virtually or in person, and start helping each other.',
    ),
  ];
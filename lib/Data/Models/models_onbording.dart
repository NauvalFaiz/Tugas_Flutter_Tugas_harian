class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final bool showSkip;
  final bool isLastPage;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.showSkip,
    required this.isLastPage,
  });
}
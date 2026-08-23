import 'package:marketi/generated/assets.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      image: Assets.images.onboarding1.path,
      title: 'Welcome to Marketi',
      description:
          'Discover a world of endless possibilities and shop from the comfort of your fingertips Browse through a wide range of products, from fashion and electronics to home.',
    ),
    OnboardingModel(
      image: Assets.images.onboarding2.path,
      title: 'Easy to Buy',
      description:
          'Find the perfect item that suits your style and needs With secure payment options and fast delivery, shopping has never been easier.',
    ),
    OnboardingModel(
      image: Assets.images.onboarding3.path,
      title: 'Wonderful User Experience',
      description:
          'Start exploring now and experience the convenience of online shopping at its best.',
    ),
  ];
}
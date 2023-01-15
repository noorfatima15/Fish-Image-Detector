import 'package:fish_detector/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 40),
        const Center(
          child: Text(
            'About',
            style: TextStyles.cyanTitle,
          ),
        ),
        const SizedBox(height: 20),
        Text(
            '''Introducing the Fish Image Classification mobile app, a powerful tool for identifying and classifying different types of fish. With a data set extracted from Kaggle, the world's largest data science community, this app is able to accurately identify and classify various species of fish with ease''',
            style: TextStyles.descriptionContent),
        const SizedBox(height: 20),
        Text(
            '''The app is designed with a user-friendly interface that makes it easy to navigate and use. Simply take a picture of a fish or upload an existing image, and the app will use advanced machine learning algorithms to identify the species and provide detailed information about it.''',
            style: TextStyles.descriptionContent),
        const SizedBox(height: 20),
        Text(
            """The data set used by the app is sourced from Kaggle, which ensures that it is accurate and up-to-date. The app is also constantly being updated with new data and features, making it the go-to tool for fish enthusiasts and professionals alike.""",
            style: TextStyles.descriptionContent),
        const SizedBox(height: 20),
        Text(
          '''Whether you're a fisherman looking to identify your catch, a marine biologist studying fish populations, or just someone who loves learning about different fish species, this app is the perfect tool for you. Download the Fish Image Classification mobile app today and start exploring the world of fish like never before.''',
          style: TextStyles.descriptionContent,
        ),
        const SizedBox(height: 20),
        Text(
          '''With regular updates and new data sets, the app is constantly improving and expanding its database, making it the most comprehensive fish classification tool available. Download the Fish Image Classification mobile app today and take the first step towards becoming a fish expert!''',
          style: TextStyles.descriptionContent,
        ),
      ],
    ));
  }
}

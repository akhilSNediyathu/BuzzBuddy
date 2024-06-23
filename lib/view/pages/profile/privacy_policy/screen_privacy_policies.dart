import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/profile/privacy_policy/widgets.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Privacy Policy',
          style: appBarTitleStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),

            kheight,
            Text(
              'Welcome to Buzz Buddy! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. Please read this policy carefully to understand our views and practices regarding your personal data and how we will treat it.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Information Collection
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'We collect information to provide better services to our users. The types of information we collect include:',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight,
            BulletPoint(
              text:
                  'Personal Data: Information that you provide to us when you register, such as your name, email address, phone number, and profile picture.',
            ),
            kheight,
            BulletPoint(
              text:
                  'Usage Data: Information about how you use the app, such as the features you use, the time and duration of your activities, and other interaction data.',
            ),
            kheight20,
            // Use of Information
            Text(
              'How We Use Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'We use the information we collect in various ways, including to:',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight,
            BulletPoint(
              text: 'Provide, operate, and maintain our app.',
            ),
            kheight,
            BulletPoint(
              text: 'Improve, personalize, and expand our app.',
            ),
            kheight,
            BulletPoint(
              text: 'Understand and analyze how you use our app.',
            ),
            kheight,
            BulletPoint(
              text:
                  'Develop new products, services, features, and functionality.',
            ),
            kheight,
            BulletPoint(
              text:
                  'Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the app, and for marketing and promotional purposes.',
            ),
            kheight,
            BulletPoint(
              text: 'Process your transactions and manage your orders.',
            ),
            kheight,
            BulletPoint(
              text: 'Find and prevent fraud.',
            ),
            kheight20,
            // Sharing of Information
            Text(
              'Sharing of Your Information',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'We do not share any information we collect about you with third parties.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Data Security
            Text(
              'Data Security',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'We use administrative, technical, and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Your Rights
            Text(
              'Your Rights and Choices',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'Depending on where you live, you may have the following rights with respect to your personal information:',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight,
            BulletPoint(
              text: 'Access and update your personal information.',
            ),
            kheight,
            BulletPoint(
              text: 'Request that we delete your personal information.',
            ),
            kheight,
            BulletPoint(
              text: 'Opt out of marketing communications.',
            ),
            kheight,
            BulletPoint(
              text: 'Restrict the processing of your personal information.',
            ),
            kheight,
            BulletPoint(
              text: 'Object to the use of your personal information.',
            ),
            kheight20,
            // Changes to This Policy
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any changes by posting the new Privacy Policy on our app. You are advised to review this Privacy Policy periodically for any changes.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Contact Us
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: blueAccent,
              ),
            ),
            kheight,
            Text(
              'If you have any questions about this Privacy Policy, please contact us at ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'akhilsnediyathu@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

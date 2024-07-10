import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/common_appbar.dart';
import 'package:flutter/material.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final double padding = mediaQuery.width * 0.05;
    final double fontSize = mediaQuery.width * 0.04;
    return Scaffold(
      appBar: customAppbar(title: 'Terms & Conditions'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BuzzBuddy - Terms and Conditions',
              style: TextStyle(
                  fontSize: fontSize + 2, fontWeight: FontWeight.bold),
            ),
            kheight16, // Add space between paragraphs
            Text(
              'Last Updated: July 10, 2024',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              'Welcome to BuzzBuddy! By using our app, you agree to comply with and be bound by the following terms and conditions. Please review these terms carefully. If you do not agree to these terms, you should not use this app.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'By accessing or using BuzzBuddy, you agree to be bound by these Terms and Conditions, as well as our Privacy Policy. If you do not agree with any part of these terms, you must not use our services.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '2. User Accounts',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              '- Registration: To use BuzzBuddy, you must create an account with a valid email address and accurate personal information.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Responsibility: You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '3. Privacy and Data Security',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              '- Data Collection: We collect and process your personal data as described in our Privacy Policy.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Data Encryption: All your data on BuzzBuddy is encrypted using industry-standard encryption technologies. This ensures that your information is secure and protected from unauthorized access.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Data Safety: We are committed to maintaining the confidentiality and security of your information. We implement a variety of security measures to ensure the safety of your personal data.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '4. User Conduct',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'You agree not to use BuzzBuddy to:',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Post any content that is unlawful, harmful, threatening, abusive, harassing, defamatory, vulgar, obscene, libelous, or otherwise objectionable.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Violate any local, state, national, or international law.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Harass, threaten, or impersonate any person or entity.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Use BuzzBuddy for any unauthorized commercial purposes.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '5. Content Ownership and Rights',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              '- User Content: You retain ownership of all the content you post on BuzzBuddy. However, by posting content, you grant BuzzBuddy a worldwide, non-exclusive, royalty-free license to use, distribute, reproduce, and display such content.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- BuzzBuddy Content: All other content on BuzzBuddy, including but not limited to text, graphics, logos, and software, is the property of BuzzBuddy or its licensors and is protected by intellectual property laws.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '6. Modifications to the Service',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'BuzzBuddy reserves the right to modify or discontinue, temporarily or permanently, the service (or any part of it) with or without notice. You agree that BuzzBuddy will not be liable to you or any third party for any modification, suspension, or discontinuation of the service.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '7. Termination',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'BuzzBuddy reserves the right to terminate or suspend your account and access to the service at our sole discretion, without notice, for conduct that we believe violates these Terms and Conditions or is harmful to other users of BuzzBuddy, us, or third parties, or for any other reason.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '8. Disclaimers and Limitation of Liability',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              '- Service Provided "As Is": BuzzBuddy is provided on an "as is" and "as available" basis. We do not warrant that the service will be uninterrupted, secure, or error-free.',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              '- Limitation of Liability: In no event will BuzzBuddy be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from (i) your use or inability to use the service; (ii) any unauthorized access to or use of our servers and/or any personal information stored therein; (iii) any bugs, viruses, trojan horses, or the like that may be transmitted to or through our service by any third party; (iv) any errors or omissions in any content or for any loss or damage incurred as a result of the use of any content posted, emailed, transmitted, or otherwise made available through the service.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '9. Governing Law',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'These Terms and Conditions are governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law principles.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '10. Changes to Terms and Conditions',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'BuzzBuddy may revise these terms from time to time. The most current version will always be available on our website. By continuing to access or use BuzzBuddy after those revisions become effective, you agree to be bound by the revised terms.',
              style: TextStyle(fontSize: fontSize),
            ),
            kheight16,
            Text(
              '11. Contact Us',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have any questions about these Terms and Conditions, please contact us at support@buzzbuddy.com.',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}

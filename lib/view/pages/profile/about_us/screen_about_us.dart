import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenAboutUs extends StatelessWidget {
  const ScreenAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: appBarTitleStyle,
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                  height: media.width * 0.6,
                  width: media.width * 0.5,
                  child: Image.asset(
                    logo,
                    fit: BoxFit.cover,
                  )),
            ),
            kheight20,
            // Welcome Text
            const Text(
              'Welcome to Buzz Buddy!',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            kheight,
            // Mission Statement
            const Text(
              'In a world where staying connected has never been more important, Buzz Buddy is here to make social interaction more vibrant, personal, and effortless. Our Flutter-powered app is designed to bring people together, fostering connections and building communities through seamless communication and engaging experiences.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight,
            // Mission Title
            const Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            kheight,
            // Mission Text
            const Text(
              'At Buzz Buddy, we believe in the power of meaningful connections. Our mission is to create a platform where everyone can freely express themselves, share their moments, and connect with like-minded individuals. Whether you’re catching up with old friends or making new ones, Buzz Buddy is here to ensure your social journey is as lively and enjoyable as possible.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // What We Offer
            const Text(
              'What We Offer',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            kheight,
            const Text(
              '- Dynamic Social Interaction: Engage with friends and communities through our intuitive and feature-rich interface.\n'
              '- Real-time Communication: Enjoy seamless chatting, photo sharing, and more, all in real-time.\n'
              '- Personalized Experience: Tailor your Buzz Buddy experience with customizable profiles, themes, and content preferences.\n'
              '- Secure and Private: Your data security is our priority. We provide robust privacy settings and data protection to ensure your information is safe and secure.\n'
              '- Community Building: Join or create groups and communities that resonate with your interests and passions.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Why Choose Buzz Buddy
            const Text(
              'Why Choose Buzz Buddy?',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            kheight,
            const Text(
              'Buzz Buddy is not just another social media app; it’s a space designed to enhance the way you connect. Built with the latest Flutter technology, our app promises a smooth and responsive user experience. We are constantly innovating, bringing new features and improvements to make your social interactions more enjoyable and engaging.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Our Journey
            const Text(
              'Our Journey',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            kheight,
            const Text(
              'Founded by a team of passionate developers and social media enthusiasts, Buzz Buddy was born out of a desire to transform the digital social landscape. We saw the need for a platform that not only connects people but also enriches their lives through meaningful interactions. Our journey is driven by your stories, your connections, and your experiences.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Join Us
            const Text(
              'Join Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            kheight,
            const Text(
              'Be a part of the Buzz Buddy community! Download our app today and start exploring a world where your social life buzzes with excitement and possibility.',
              style: TextStyle(fontSize: 16.0),
            ),
            kheight20,
            // Contact Us
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We’d love to hear from you! If you have any questions, feedback, or suggestions, feel free to reach out to us at ',
              style: TextStyle(fontSize: 16.0),
            ),
            // InkWell(
            //   onTap: () {
            //     // Handle email tap
            //     final Uri emailUri = Uri(
            //       scheme: 'mailto',
            //       path: 'support@buzzbuddyapp.com',
            //     );
            //     launchUrl(emailUri);
            //   },
            //   child: const Text(
            //     'support@buzzbuddyapp.com',
            //     style: TextStyle(
            //       fontSize: 16.0,
            //       color: Colors.blue,
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),
            // kheight,
            // const Text(
            //   'Follow us on ',
            //   style: TextStyle(fontSize: 16.0),
            // ),
            // const Row(
            //   children: [
            //     SocialIcon(
            //       icon: Icons.facebook,
            //       url:
            //           'https://facebook.com/yourpage', // Replace with your Facebook page URL
            //     ),
            //     SocialIcon(
            //       icon: Icons.bluetooth_outlined,
            //       url:
            //           'https://twitter.com/yourprofile', // Replace with your Twitter profile URL
            //     ),
            //     SocialIcon(
            //       icon: Icons.bluetooth_outlined,
            //       url:
            //           'https://instagram.com/yourprofile', // Replace with your Instagram profile URL
            //     ),
            //   ],
            // ),
            kheight50,
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const SocialIcon({super.key, required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 32.0, color: Colors.blueAccent),
      onPressed: () {
        launchUrl(Uri.parse(url));
      },
    );
  }
}

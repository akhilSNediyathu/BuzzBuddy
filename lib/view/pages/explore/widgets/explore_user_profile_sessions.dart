import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/profile_succes_dummy_container.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/repeated_column.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/user_and_bio_tile.dart';
import 'package:flutter/material.dart';

class ExploreUserProfileSession1 extends StatelessWidget {
  final Size media;
  final String profileImage;
  final String coverImage;
  final String userName;
  final String bio;
  final VoidCallback onEditProfile;

  const ExploreUserProfileSession1({
    required this.media,
    required this.profileImage,
    required this.coverImage,
    required this.userName,
    required this.bio,
    required this.onEditProfile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        profileContainer(media, profileImage, coverImage),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: customMaterialButton(
                borderRadius: 10,
                color: kPrimaryColor,
                onPressed: onEditProfile,
                text: 'unFollow',
                width: media.height * 0.1,
                height: media.height * 0.05,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: customMaterialButton(
                borderRadius: 10,
                color: kPrimaryColor,
                onPressed: onEditProfile,
                text: 'messsage',
                width: media.height * 0.1,
                height: media.height * 0.05,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: userNameAndBio(userName, bio),
        ),
      ],
    );
  }
}

class ExploreUserProfileSessions2 extends StatelessWidget {
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  const ExploreUserProfileSessions2({
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customTextColumn(
              text1: '',
              text2: 'Posts',
              textStyle: profilecolumnStyle,
              onTap: () {}),
          customTextColumn(
            text1: '',
            text2: 'Followers',
            textStyle: profilecolumnStyle,
            onTap: onFollowersTap,
          ),
          customTextColumn(
            text1: '',
            text2: 'Following',
            textStyle: profilecolumnStyle,
            onTap: onFollowingTap,
          ),
        ],
      ),
    );
  }
}

class ExploreSession3 extends StatelessWidget {
  const ExploreSession3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0, 
        childAspectRatio: 1.0, 
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        // Generate random colors for the containers
        final color = Colors.primaries[index % Colors.primaries.length];
        return Container(
          color: color,
          child: Center(
            child: Text(
              'Item $index',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

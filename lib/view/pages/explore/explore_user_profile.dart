import 'package:buzz_buddy/model/explore_users_user_model.dart';
import 'package:buzz_buddy/utils/constants.dart';

import 'package:buzz_buddy/view/pages/explore/widgets/explore_user_profile_sessions.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/main_sessions.dart';

import 'package:flutter/material.dart';

class ScreenExploreUserProfile extends StatelessWidget {
  final String userId;
  final UserIdSearchModel user;
  const ScreenExploreUserProfile(
      {super.key, required this.userId, required this.user});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        toolbarHeight: 40,
      ),
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: ExploreUserProfileSession1(
                media: media,
                profileImage: user.profilePic,
                coverImage: user.backGroundImage,
                userName: user.name.toString(),
                bio: user.bio.toString(),
                onEditProfile: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSession2(
                onPostsTap: () {},
                onFollowersTap: () {},
                onFollowingTap: () {},
              ),
            ),
          ];
        },
        body: SizedBox(),
      )),
    );
  }
}

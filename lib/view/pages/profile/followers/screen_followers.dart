import 'package:buzz_buddy/model/explore_users_user_model.dart';
import 'package:buzz_buddy/model/followers_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
import 'package:buzz_buddy/view/pages/explore/explore_user_profile.dart';
import 'package:flutter/material.dart';

class ScreenFollowers extends StatelessWidget {
  const ScreenFollowers({super.key, required this.model});
  final FollowersModel model;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Followers',
          style: appBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: model.totalCount == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_off,
                    size: media.height * 0.1,
                    color: grey,
                  ),
                  kheight,
                  const Text(
                    'No followers yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        Theme.of(context).brightness == Brightness.light
                            ? lightModeShadow
                            : darkModeShadow,
                      ],
                      color: Theme.of(context).brightness == Brightness.light
                          ? kwhiteColor
                          : Colors.grey[900]),
                  height: 60,
                  child: CustomListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenExploreUserProfile(
                                  userId: model.followers[index].id,
                                  user: UserIdSearchModel(
                                      bio: model.followers[index].bio ?? '',
                                      id: model.followers[index].id,
                                      userName: model.followers[index].userName,
                                      email: model.followers[index].userName,
                                      profilePic:
                                          model.followers[index].profilePic,
                                      online: model.followers[index].online,
                                      blocked: model.followers[index].blocked,
                                      verified: model.followers[index].verified,
                                      role: model.followers[index].role,
                                      isPrivate:
                                          model.followers[index].isPrivate,
                                      backGroundImage: model
                                          .followers[index].backGroundImage,
                                      createdAt:
                                          model.followers[index].createdAt,
                                      updatedAt:
                                          model.followers[index].updatedAt,
                                      v: model.followers[index].v))));
                    },
                    buttonText: 'unfollow',
                    profileImageUrl: model.followers[index].profilePic,
                    titleText: model.followers[index].userName,
                    imageSize: media.height * 0.05,
                    backgroundColor: kwhiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              itemCount: model.totalCount,
            ),
    );
  }
}

import 'package:buzz_buddy/model/followers_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
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
              itemBuilder: (context, index) => Card(
                child: CustomListTile(
                  buttonText: 'unfollow',
                  profileImageUrl: model.followers[index].profilePic,
                  titleText: model.followers[index].userName,
                  imageSize: media.height * 0.05,
                  backgroundColor: kwhiteColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              itemCount: model.totalCount,
            ),
    );
  }
}

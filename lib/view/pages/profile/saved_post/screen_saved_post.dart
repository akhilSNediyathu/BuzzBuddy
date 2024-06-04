import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/post_listing_page_tile.dart';
import 'package:flutter/material.dart';

class ScreenSavedPost extends StatelessWidget {
  const ScreenSavedPost({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Posts'),
        automaticallyImplyLeading: true,
        backgroundColor: kPrimaryColor,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return PostListingPageTile(
              media: media,
              mainImage: mainImages[index],
              profileImage: profileImages[index]);
        },
        itemCount: 5,
      ),
    );
  }
}

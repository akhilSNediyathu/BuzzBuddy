import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
import 'package:flutter/material.dart';

class ScreenFollowers extends StatelessWidget {
  const ScreenFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: true,
        title: const Text('Followers ',style: appBarTitleStyle,),
        centerTitle: true,


      ),
      body: ListView.builder(itemBuilder: (context,index)=>Card(
        child: CustomListTile(profileImageUrl: profileImages[index], titleText: account[index], imageSize: media.height*0.05, backgroundColor: kwhiteColor, borderRadius: BorderRadius.circular(100)) ,
      ),itemCount:account.length ,
      ),
    );
  }
}
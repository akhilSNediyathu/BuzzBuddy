import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:flutter/material.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text('Chat Hub',style:appBarTitleStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemBuilder: (context,index)=>Card(
          child: ListTile(
            leading: Container(
                    
                    height: media.height*0.07,width:media.height*0.07,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(profileImages[index]),fit: BoxFit.cover),
                      color: kwhiteColor,
                      borderRadius: kradius100
                    ),
                  ),
                  title: Text(account[index]),
                  
          
          ),
        ),
        itemCount: profileImages.length,
        ),
      ),
    );
  }
}
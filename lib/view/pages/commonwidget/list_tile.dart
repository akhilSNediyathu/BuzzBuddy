import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String profileImageUrl;
  final String titleText;
  final double imageSize;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;

  final VoidCallback? onTap;
  final VoidCallback? onUnfollow;

  const CustomListTile(
      {super.key,
      required this.profileImageUrl,
      required this.titleText,
      required this.imageSize,
      required this.backgroundColor,
      required this.borderRadius,
      this.onTap,
      this.onUnfollow});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: onUnfollow != null
          ? ElevatedButton(
              onPressed: onUnfollow,
              // style: ElevatedButton.styleFrom(
              //   minimumSize: const Size(75, 36),
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   // backgroundColor: kwhiteColor,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   textStyle: const TextStyle(fontSize: 14),
              // ),
              child: const Text('Unfollow',style: TextStyle(color: kwhiteColor),),
            )
          : null,
      onTap: onTap,
      leading: Container(
        height: imageSize,
        width: imageSize,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(profileImageUrl),
            fit: BoxFit.cover,
          ),
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
      ),
      title: Text(titleText),
    );
  }
}

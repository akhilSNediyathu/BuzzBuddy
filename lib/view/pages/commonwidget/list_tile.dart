import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

// Example color value for blueaccent2

class CustomListTile extends StatelessWidget {
  final String buttonText;
  final String profileImageUrl;
  final String titleText;
  final String? subtitleText;
  final double imageSize;
  final Color backgroundColor;
  final BorderRadiusGeometry borderRadius;

  final VoidCallback? onTap;
  final VoidCallback? onUnfollow;

  const CustomListTile({
    super.key,
    required this.profileImageUrl,
    required this.buttonText,
    required this.titleText,
    this.subtitleText, // Added subtitle text
    required this.imageSize,
    required this.backgroundColor,
    required this.borderRadius,
    this.onTap,
    this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      title: Text(
        titleText,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text(
      //   subtitleText,
      //   style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      // ),
      trailing: MaterialButton(
        minWidth: 80,
        height: 27,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: kPrimaryColor),
        ),
        onPressed: onUnfollow, // Assuming this is the button action
        child: Text(
          buttonText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

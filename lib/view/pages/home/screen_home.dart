import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/home/commonwidgets/mainwidget.dart';
import 'package:buzz_buddy/view/pages/home/suggestions_page/screen_users_suggestion.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

String logginedUserToken = '';
String logginedUserId = '';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final List<String> profileImages = [
    'https://pyxis.nymag.com/v1/imgs/af9/4b3/d79e0525b97fd56eea6dd98f2743be69a1-17-daenerys.rhorizontal.w710.jpg',
    'https://images.thequint.com/thequint%2F2018-04%2F91702cf7-aea4-4506-b347-d74bdc8ea38b%2F1894926e_68a9_4078_b24f_ab4e12fbbbb0.jpeg?rect=0%2C0%2C1024%2C576',
    'https://static.hbo.com/content/dam/hbodata/series/game-of-thrones/character/s5/robert-stark-1920.jpg',
    'https://qph.cf2.quoracdn.net/main-qimg-3a3ca39b7809555ab83e6c4fb8474afc-lq',
    'https://static.wikia.nocookie.net/gameofthrones/images/d/d9/Tyrion_Lannister.jpg/revision/latest/scale-to-width-down/1024?cb=20110411054140'
  ];

  final List<String> mainImages = [
    'https://hips.hearstapps.com/hmg-prod/images/the-witcher-n-s3-e4-00-28-49-08-64c2d4097437c.jpg?crop=0.502xw:1.00xh;0.266xw,0&resize=1200:*',
    'https://images.bauerhosting.com/legacy/empire-images/features/5cde8a00133d503e3a49e503/GOT-MAIN.jpg?ar=16%3A9&fit=crop&crop=top&auto=format&w=1440&q=80',
    'https://c4.wallpaperflare.com/wallpaper/782/297/164/game-of-thrones-4k-best-desktop-download-wallpaper-preview.jpg',
    'https://wallpapers.com/images/hd/peter-dinklage-tyrion-lannister-0xqszly1l5t0241r.jpg',
    'https://www.mensjournal.com/.image/t_share/MjA0ODc4NDc1NzI5ODM5NDUw/9.png'
  ];

  final List<String> likedPerson = [
    'Roman Pierce',
    'Tej Parkor',
    'Ramsey Allison',
    'Ken Block',
    'Luke Hobbs'
  ];

  final List<String> date = [
    'May 15',
    ' May 16',
    'May 26',
    'June 10',
    'June 12'
  ];

  final List<String> description = [
    'Thinking about a knockout audio system for your car? Not sure what you need, want, or can afford? Car Audio For Dummies is a great place to find some answers! But wait — what if speakers that vibrate your floorboards',
    'This is a must-have for anyone interested in achieving better performance through car modification!So you want to turn your Yugo into a Viper? Sorry--you need a certified magician. But if you want to turn your sedate',
    'A practical guide that gets you geared up with proper riding techniques, safety gear, indispensable items for long trips, and handling characteristics of various motorcycle types Few activities offer more fun and',
    'Auto Repair For Dummies, 2nd Edition (9781119543619) was previously published as Auto Repair For Dummies, 2nd Edition (9780764599026). While this version features a new Dummies cover and design, the',
    'Drive into the 21st century in an electric car With falling cost of ownership, expanded incentives for purchasing, and more model and body type options than ever, it may finally be time to retire the old gas-'
  ];

  final List<String> account = [
    'Paul William Walker',
    'Jordana Breuster',
    'Dominic Toretto',
    'Michele Rodregues',
    'Decard Shaw'
  ];
  @override
  void initState() {
    context
        .read<AllFollowersPostsBloc>()
        .add(AllFollowersPostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        title: Image.asset(
          appBarLogo,
          width: media.width * 0.26,
        ),
        elevation: 2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>const ScreenUsersSuggestion()));
              },
              icon: const Icon(
                Iconsax.user_cirlce_add,
              ))
        ],
      ),
      // backgroundColor: kwhiteColor,
      body: BlocBuilder<AllFollowersPostsBloc, AllFollowersPostsState>(
        builder: (context, state) {
          if (state is AllFollowersPostsSuccesfulState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeWidgetMain(
                    media: media,
                    profileImage: state.post[index].userId.profilePic,
                    mainImage: state.post[index].image,
                  ),
                );
              },
              itemCount: state.post.length,
            );
          } else if (state is AllFollowersPostsLoadingState) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: grey300!,
                  highlightColor: grey100!,
                  child: shimmerWidget1(media)),
            );
          } else {
            return const Center(
              child: Text('something went wrong try refresh'),
            );
          }
        },
      ),
    );
  }
}

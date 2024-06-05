import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';

import 'package:buzz_buddy/view/pages/profile/edit_profile/screen_edit_profiile.dart';
import 'package:buzz_buddy/view/pages/profile/followers/screen_followers.dart';
import 'package:buzz_buddy/view/pages/profile/following/screen_following.dart';
import 'package:buzz_buddy/view/pages/profile/settings_page/screen_settings.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/repeated_column.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/saved_and_posts_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
     context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    return BlocConsumer<FetchMyPostBloc, FetchMyPostState>(
      listener: (context, state) {
        if(state is FetchMyPostErrorState){
          customSnackbar(context, state.error, amber);
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: const Text(
                'Profile',
                style: appBarTitleStyle,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>const ScreenSettings(),
                          ));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            backgroundColor: kwhiteColor,
            body: SafeArea(
              child: NestedScrollView(headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 210,
                    width: media.width,
                    decoration: BoxDecoration(
                      color: kwhiteColor,
                      image: DecorationImage(
                        image: NetworkImage(mainImages[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: -60,
                          left: 20,
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: kwhiteColor,
                              border: Border.all(width: 5, color: kwhiteColor),
                              image: DecorationImage(
                                image: NetworkImage(
                                  profileImages[0],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  kheight15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: customMaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const ScreenEditProfiile()));
                          },
                          text: 'Edit Profile',
                          color: const Color.fromARGB(255, 234, 232, 232),
                          width: media.height * 0.12,
                          height: media.height * 0.05,
                          textStyle:
                              const TextStyle( fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Daenerys Targaryen', style: appBarTitleStyle),
                        Text('Personal blog')
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customTextColumn(
                            text1: '200',
                            text2: 'Post',
                            textStyle: profilecolumnStyle,
                            onTap: () {}),
                        customTextColumn(
                            text1: '111k',
                            text2: 'Followers',
                            textStyle: profilecolumnStyle,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const ScreenFollowers()));
                            }),
                        customTextColumn(
                            text1: '50',
                            text2: 'Following',
                            textStyle: profilecolumnStyle,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const ScreenFollowing()));
                            }),
                      ],
                    ),
                  ),
            
              
              
              
                  
                  
                ],
              ),
                  )
                ];
              }, body: 

Column(
  children: [
          const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TabBar(
                      labelColor:black,
                      unselectedLabelColor: grey,
                      indicatorColor: black,
                      tabs: [
                        Tab(text: 'My Posts'),
                        Tab(text: 'Saved Posts'),
                      ],
                    ),
                  ),
    Expanded(
      child: TabBarView(
        children: [
          BlocBuilder<FetchMyPostBloc, FetchMyPostState>(
            builder: (context, state) {
             if (state is FetchMyPostSuccesState){
              return MyPostsGrid(post:state.posts);
             }return Center(child: CircularProgressIndicator(),);
            },
          ),
          SavedPostsGrid(),
        ],
      ),
    ),
  ],
),)
              
              
             
            ),
          ),
        );
      },
    );
  }
}




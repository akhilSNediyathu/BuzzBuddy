import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/logined_user_fetch_posts_bloc/logined_user_fetch_post_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/commonwidget/snackbars.dart';
import 'package:buzz_buddy/view/pages/profile/edit_profile/screen_edit_profiile.dart';
import 'package:buzz_buddy/view/pages/profile/followers/screen_followers.dart';
import 'package:buzz_buddy/view/pages/profile/following/screen_following.dart';
import 'package:buzz_buddy/view/pages/profile/settings_page/screen_settings.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/profile_succes_dummy_container.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/repeated_column.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/round_material_button.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/saved_and_posts_grid.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/user_and_bio_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  void initState() {
    context.read<FetchMyPostBloc>().add(FetchAllMyPostsEvent());
    context.read<LoginUserDetailsBloc>().add(OnLoginedUserDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return BlocConsumer<FetchMyPostBloc, FetchMyPostState>(
      listener: (context, state) {
        if (state is FetchMyPostErrorState) {
          customSnackbar(context, state.error, amber);
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              // backgroundColor: kPrimaryColor,
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
                            builder: (context) => const ScreenSettings(),
                          ));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            // backgroundColor: kwhiteColor,
            body: SafeArea(
              child: BlocBuilder<LoginUserDetailsBloc, LoginUserDetailsState>(
                builder: (context, state) {
                  return NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<LoginUserDetailsBloc,
                                  LoginUserDetailsState>(
                                builder: (context, state) {
                                  if (state
                                      is LoginUserDetailsDataFetchSuccesState) {
                                    return profileContainer(
                                        media,
                                        state.userModel.profilePic,
                                        state.userModel.backGroundImage);
                                  } else if (state
                                      is LoginUserDetailsDataFetchLoadingState) {
                                    return profileImageShimmerContainer(
                                        context);
                                  } else {
                                    return profileContainer(
                                        media, mainImages[0], mainImages[1]);
                                  }
                                },
                              ),
                              kheight15,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: customMaterialButton(
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                     ScreenEditProfile()));
                                      },
                                      text: 'Edit Profile',
                                      width: media.height * 0.12,
                                      height: media.height * 0.05,
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: BlocBuilder<LoginUserDetailsBloc,
                                    LoginUserDetailsState>(
                                  builder: (context, state) {
                                    if (state
                                        is LoginUserDetailsDataFetchSuccesState) {
                                      return userNameAndBio(
                                          state.userModel.userName,
                                          state.userModel.bio ?? '');
                                    } else {
                                      return userNameAndBio('', '');
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BlocConsumer<FetchMyPostBloc,
                                        FetchMyPostState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        if (state is FetchMyPostSuccesState) {
                                          return customTextColumn(
                                              text1:
                                                  state.posts.length.toString(),
                                              text2: 'Post',
                                              textStyle: profilecolumnStyle,
                                              onTap: () {});
                                        }
                                        return customTextColumn(
                                            text1: '0',
                                            text2: 'Post',
                                            textStyle: profilecolumnStyle,
                                            onTap: () {});
                                      },
                                    ),
                                    customTextColumn(
                                        text1: '111k',
                                        text2: 'Followers',
                                        textStyle: profilecolumnStyle,
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const ScreenFollowers()));
                                        }),
                                    customTextColumn(
                                        text1: '50',
                                        text2: 'Following',
                                        textStyle: profilecolumnStyle,
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      const ScreenFollowing()));
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ];
                    },
                    body: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TabBar(
                            labelColor: black,
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
                                if (state is FetchMyPostSuccesState) {
                                  return MyPostsGrid(post: state.posts);
                                } else if (state is FetchMyPostLoadingState) {
                                  return Center(
                                      child: LoadingAnimationWidget
                                          .fourRotatingDots(
                                              color: kPrimaryColor, size: 30));
                                } else {
                                  return const Center(
                                      child: Text('No posts available'));
                                }
                              }),
                              const SavedPostsGrid(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

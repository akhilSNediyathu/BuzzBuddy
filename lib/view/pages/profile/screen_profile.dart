import 'package:buzz_buddy/model/logined_user_details_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:buzz_buddy/view/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:buzz_buddy/view/bloc/fetch_my_post/fetch_my_post_bloc.dart';
import 'package:buzz_buddy/view/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:buzz_buddy/view/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
import 'package:buzz_buddy/view/pages/profile/edit_profile/screen_edit_profiile.dart';
import 'package:buzz_buddy/view/pages/profile/followers/screen_followers.dart';
import 'package:buzz_buddy/view/pages/profile/following/screen_following.dart';
import 'package:buzz_buddy/view/pages/profile/my_post/screen_my_post.dart';
import 'package:buzz_buddy/view/pages/profile/settings_page/screen_settings.dart';
import 'package:buzz_buddy/view/pages/profile/widgets/main_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String logginedUserProfileImage = '';
String profilepageUserId = '';
String profileuserName = '';
String coverImageUrl = '';
LoginUserModel userdetails = LoginUserModel(
    id: '',
    userName: '',
    email: '',
    phone: '',
    online: true,
    blocked: false,
    verified: false,
    role: '',
    isPrivate: false,
    createdAt: DateTime(20242024 - 06 - 24),
    updatedAt: DateTime(20242024 - 06 - 24),
    profilePic: '',
    backGroundImage: '');

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
    context.read<FetchFollowersBloc>().add(OnfetchAllFollowersEvent());
    context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
    context.read<FetchSavedPostsBloc>().add(SavedPostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: appBarTitleStyle),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenSettings(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: BlocBuilder<LoginUserDetailsBloc, LoginUserDetailsState>(
            builder: (context, state) {
              if (state is LoginUserDetailsDataFetchSuccesState) {
                profileuserName =
                    state.userModel.name ?? state.userModel.userName;
                logginedUserProfileImage = state.userModel.profilePic;
                profilepageUserId = state.userModel.id;
                userdetails = state.userModel;
                coverImageUrl = state.userModel.backGroundImage;

                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: ProfileSession1(
                          media: media,
                          profileImage: logginedUserProfileImage,
                          coverImage: coverImageUrl,
                          userName: profileuserName,
                          bio: state.userModel.bio ?? '',
                          onEditProfile: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => ScreenEditProfile(
                                  cvImage: coverImageUrl,
                                  prImage: logginedUserProfileImage,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ProfileSession2(
                          onPostsTap: () {
                            if (context.read<FetchMyPostBloc>().state
                                is FetchMyPostSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ScreenMyPost(
                                    index: 0,
                                    post: (context.read<FetchMyPostBloc>().state
                                            as FetchMyPostSuccesState)
                                        .posts,
                                  ),
                                ),
                              );
                            }
                          },
                          onFollowersTap: () {
                            if (context.read<FetchFollowersBloc>().state
                                is FetchFollowersSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => ScreenFollowers(
                                    model: (context
                                            .read<FetchFollowersBloc>()
                                            .state as FetchFollowersSuccesState)
                                        .followersModel,
                                  ),
                                ),
                              );
                            }
                          },
                          onFollowingTap: () {
                            if (context.read<FetchFollowingBloc>().state
                                is FetchFollowingSuccesState) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const ScreenFollowing(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ];
                  },
                  body: const ProfileSession3(),
                );
              } else if (state is LoginUserDetailsDataFetchLoadingState) {
                return profileImageShimmerContainer(context);
              } else {
                return const Center(child: Text('Failed to load profile'));
              }
            },
          ),
        ),
      ),
    );
  }
}

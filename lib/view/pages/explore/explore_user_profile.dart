import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

// Import your specific BLoCs and other dependencies
import 'package:buzz_buddy/model/explore_users_user_model.dart';
import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:buzz_buddy/view/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:buzz_buddy/view/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:buzz_buddy/view/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/bloc/profile_posts_bloc/profile_bloc.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/explore_user_profile_sessions.dart';

class ScreenExploreUserProfile extends StatefulWidget {
  final String userId;
  final UserIdSearchModel user;

  const ScreenExploreUserProfile(
      {super.key, required this.userId, required this.user});

  @override
  State<ScreenExploreUserProfile> createState() =>
      _ScreenExploreUserProfileState();
}

class _ScreenExploreUserProfileState extends State<ScreenExploreUserProfile> {

  String posts = '';
  @override
  void initState() {
    context
        .read<ProfileBloc>()
        .add(ProfileInitialPostFetchEvent(userId: widget.userId));
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<FetchFollowingBloc>().add(OnFetchFollowingUsersEvent());
      context
          .read<GetConnectionsBloc>()
          .add(ConnectionsInitilFetchEvent(userId: widget.user.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user.name ?? widget.user.userName,
          style: appBarTitleStyle,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: MultiBlocBuilder(
          blocs: [
            context.watch<LoginUserDetailsBloc>(),
            context.watch<ProfileBloc>(),
            context.watch<FetchFollowingBloc>(),
            context.watch<GetConnectionsBloc>(),
            context.watch<FollowUnfollowBloc>(),
          ],
          builder: (context, state) {
            var state2 = state[1];
            if (state2 is ProfilePostFetchSuccesfulState) {
              posts = state2.posts.length.toString();
            }

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: ExploreUserProfileSession1(
                        user: widget.user,
                      media: media,
                      profileImage: widget.user.profilePic,
                      coverImage: widget.user.backGroundImage,
                      userName: widget.user.name.toString(),
                      bio: widget.user.bio.toString(),
                      onEditProfile: () {},
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ExploreUserProfileSessions2(
                     
                      onPostsTap: () {},
                      onFollowersTap: () {},
                      onFollowingTap: () {},
                    ),
                  ),
                ];
              },
              body: const Column(
                children: [
                  kheight,
                  Text(
                    'Posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  kheight,
                  Expanded(child: ExploreSession3()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

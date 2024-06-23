import 'package:buzz_buddy/firebase_options.dart';
import 'package:buzz_buddy/utils/themes.dart';
import 'package:buzz_buddy/view/pages/bloc/add_post_bloc/add_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/all_followers_posts_bloc/all_followers_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_saved_posts/fetch_saved_posts_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_connections_bloc/get_connections_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/like_unlike_bloc/like_unlike_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/saved_post_bloc/saved_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/search_user_bloc/explore_page_search_users_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/comment_post_bloc/comment_post_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/delete_comment_bloc/delete_comment_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/edit_user_profile_bloc/edit_user_profile_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_explore_bloc/fetch_explore_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_following_bloc/fetch_following_bloc.dart';

import 'package:buzz_buddy/view/pages/bloc/fetch_my_post/fetch_my_post_bloc.dart';

import 'package:buzz_buddy/view/pages/bloc/forgot_pass_bloc/forgot_password_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/get_comments_bloc/get_comments_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/login_bloc/login_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/logined_user_details/login_user_details_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/otp_verification/otp_verification_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/suggestions_bloc/fetch_user_suggestions_bloc.dart';
import 'package:buzz_buddy/view/pages/splash_screen/screen_splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/pages/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => OtpVerificationBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchMyPostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchUserSuggestionsBloc(),
        ),
        BlocProvider(
          create: (context) => FollowUnfollowBloc(),
        ),
        BlocProvider(
          create: (context) => AllFollowersPostsBloc(),
        ),
        BlocProvider(
          create: (context) => LoginUserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => EditUserProfileBloc(),
        ),
        BlocProvider(
          create: (context) => FetchFollowersBloc(),
        ),
        BlocProvider(
          create: (context) => FetchFollowingBloc(),
        ),
        BlocProvider(
          create: (context) => FetchExploreBloc(),
        ),
        BlocProvider(
          create: (context) => GetCommentsBloc(),
        ),
        BlocProvider(
          create: (context) => CommentPostBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteCommentBloc(),
        ),
        BlocProvider(
          create: (context) => ExplorePageSearchUsersBloc(),
        ),
           BlocProvider(
          create: (context) => LikeUnlikePostBloc(),
        ),
           BlocProvider(
          create: (context) => SavedPostBloc(),
        ),
           BlocProvider(
          create: (context) => FetchSavedPostsBloc(),
        ),
            BlocProvider(
          create: (context) => GetConnectionsBloc(),
        ),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightModeTheme,
        darkTheme: Themes.darkModeTheme,
        home: const ScreenSplash(),
      ),
    );
  }
}

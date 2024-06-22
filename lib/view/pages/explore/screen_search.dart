import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/search_user_bloc/explore_page_search_users_bloc.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_explore_bloc/fetch_explore_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/loading_animation_widget.dart';import 'package:buzz_buddy/view/pages/explore/debouncer/debouncer.dart';
import 'package:buzz_buddy/view/pages/explore/explore_user_profile.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/custom_search_field.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/explore_page_shimmer.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/main_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 700);
  String onchangevalue = '';

  @override
  void initState() {
    super.initState();
    context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent());
  }

  Future<void> _onRefresh() async {
    context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? kwhiteColor
            : black,
        title: const Text(
          'Explore',
          style: appBarTitleStyle,
        ),
        bottom: PreferredSize(
          preferredSize: Size(media.width, 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: TextFormFieldExplore(
              controller: searchController,
              hintText: 'Search',
              keyboard: TextInputType.text,
              onTextChanged: (String value) {
                setState(() {
                  onchangevalue = value;
                });
                if (value.isNotEmpty) {
                  _debouncer.run(() {
                    context
                        .read<ExplorePageSearchUsersBloc>()
                        .add(OnSearchAllUsersEvent(query: value));
                  });
                }
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<FetchExploreBloc, FetchExploreState>(
          builder: (context, state) {
            if (state is FetchExplorePostsLoadingState) {
              return Center(child: loadingAnimationWidget());
            } else if (state is FetchExplorePostsSuccesState) {
              if (onchangevalue.isEmpty) {
                return postsGridViewWidget(state, media, context, _onRefresh);
              } else {
                return BlocBuilder<ExplorePageSearchUsersBloc,
                    ExplorePageSearchUsersState>(
                  builder: (context, searchState) {
                    if (searchState is ExplorePageSearchUsersLoadingState) {
                      return explorePostShimmerLoading();
                    } else if (searchState
                        is ExplorePageSearchUserSuccesState) {
                      return searchState.users.isEmpty
                          ? errorStateWidget('No User Found!', greyMeduim)
                          : filteredUsersListView(searchState, media,);
                    } else {
                      return errorStateWidget('No User Found!', greyMeduim);
                    }
                  },
                );
              }
            } else if (state is FetchExplorePostsErrorState) {
              return fetchExploreErrorReloadWidget(context);
            } else {
              // unexpected states
              return errorStateWidget(
                  'Something went wrong, Try refreshing.', greyMeduim);
            }
          },
        ),
      ),
    );
  }
}

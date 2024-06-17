import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/bloc/fetch_explore_bloc/fetch_explore_bloc.dart';
import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/loading_animation_widget.dart';
import 'package:buzz_buddy/view/pages/explore/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Trigger the fetch posts event on initialization
    context.read<FetchExploreBloc>().add(OnFetchExplorePostsEvent());
  }

  // Refresh the posts
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
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<FetchExploreBloc, FetchExploreState>(
          builder: (context, state) {
            if (state is FetchExplorePostsSuccesState) {
              // Display the fetched posts in a grid view
              debugPrint('Posts fetched successfully: ${state.posts.length}');
              if (state.posts.isEmpty) {
                return const Center(
                  child: Text(
                    'No posts available.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    debugPrint(
                        'Rendering post at index $index with image URL: ${post.image}');
                    return GestureDetector(
                      onTap: () {
                        // Handle image tap if needed
                        debugPrint('Post tapped: ${post.image}');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            post.image, // URL of the image
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is FetchExplorePostsLoadingState) {
              // Show loading animation while posts are being fetched
              return Center(
                child: loadingAnimationWidget(),
              );
            } else if (state is FetchExplorePostsErrorState) {
              // Show error message if something goes wrong
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              const      Text(
                      'Something went wrong. Try refreshing.',
                      style: TextStyle(color: red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context
                          .read<FetchExploreBloc>()
                          .add(OnFetchExplorePostsEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              // Fallback for any other unexpected states
              return const Center(
                child: Text(
                  'Unexpected state encountered. Try refreshing.',
                 
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/utils/dummydata.dart';
import 'package:buzz_buddy/view/pages/search/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});
  final searchController = TextEditingController();

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
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: TextFormFieldExplore(
                    controller: searchController,
                    hintText: 'search',
                    keyboard: TextInputType.emailAddress),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          child: MasonryGridView.builder(
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(mainImages[index % mainImages.length]),
              );
            },
          ),
        ));
  }
}

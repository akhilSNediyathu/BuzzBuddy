import 'package:buzz_buddy/utils/constants.dart';
import 'package:buzz_buddy/view/pages/search/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';

class ScreenSearch extends StatelessWidget {
   ScreenSearch({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore',style: appBarTitleStyle,),
        bottom: PreferredSize(preferredSize:Size(media.width, 50) , child: 
        Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
        child: TextFormFieldExplore(controller: searchController, hintText: 'search', keyboard: TextInputType.emailAddress)
        
        ,)
        
        ),
      ),
      body: const Center(
        child: Text("search page"),
      ),
    );
  }
}
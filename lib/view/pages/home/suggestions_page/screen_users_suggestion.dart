// import 'package:buzz_buddy/model/user_suggestion_model.dart';
// import 'package:buzz_buddy/utils/constants.dart';
// import 'package:buzz_buddy/view/pages/bloc/suggestions_bloc/fetch_user_suggestions_bloc.dart';
// import 'package:buzz_buddy/view/pages/commonwidget/funtionwidgets/shimmer_widgets.dart';
// import 'package:buzz_buddy/view/pages/commonwidget/list_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';

// class ScreenUsersSuggestion extends StatefulWidget {
//   const ScreenUsersSuggestion({super.key});

//   @override
//   State<ScreenUsersSuggestion> createState() => _ScreenUsersSuggestionState();
// }

// class _ScreenUsersSuggestionState extends State<ScreenUsersSuggestion> {
//     List<UserDetailsModel> suggessionList = [];
//   @override
//   void initState() {
//     context.read<FetchUserSuggestionsBloc>().add(OnfetchUserSuggestionEvent());
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         centerTitle: true,
//         title: const Text('Suggestions'),
//       ),
//       body:  BlocConsumer<FetchUserSuggestionsBloc, FetchUserSuggestionsState>(
//         listener: (context, state) {
          
//         },
//         builder: (context, state) {
//           if(state is FetchUserSuggestionsLoadingState){
            
//             return ListView.builder(itemBuilder: (context, index) => CustomListTile(profileImageUrl: suggessionList[index].profilePic, titleText: suggessionList[index].name.toString(),imageSize: media.height * 0.05,
//               backgroundColor: kwhiteColor,
//               borderRadius: BorderRadius.circular(100),),itemCount: suggessionList.length,); 
//           }
//          else{
//           return Shimmer.fromColors(
//                     baseColor: grey300!,
//                     highlightColor: grey100!,
//                     child: shimmerWidget1(media));

//          }
//         },
//       ),
//     );
//   }
// }
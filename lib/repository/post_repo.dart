import 'dart:convert';

import 'package:buzz_buddy/controller/utils/api_urls.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:photo_manager/photo_manager.dart';
class PostRepo{
  static var client = http.Client();
  //Add post 
  static Future<Response?> addPost (String description, AssetEntity image)async{
    try {
      final imageUrl = await PostRepo.uploadImage(await image.file);
          final userid = await getUserId();
      final token = await getUsertoken();
       final post = {
        'imageUrl': imageUrl,
        'description': description,
        'userId': userid
      };
         var response = await client.post(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.addpostUrl}'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
      debugPrint(response.statusCode.toString());
      return response;
    } catch (e) {
      return null;
    }
  }
  // upload to cloudinary
  static Future uploadImage(imagePath) async {
   try {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dkuqbewgb/image/upload'); 
     // final file = await imagePath.file ?? imagePath;
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'yrxdjmch'
      ..files.add(await http.MultipartFile.fromPath('file', imagePath!.path));
    final response = await request.send();
   debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
   } catch (e) {
     debugPrint(e.toString());
   }

  }
  //Delete Post
  static Future deletePost(String postId) async {
    try {
      final token = await getUsertoken();
      var response = await client.delete(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.deletePost}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
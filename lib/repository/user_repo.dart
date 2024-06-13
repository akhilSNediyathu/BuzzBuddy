import 'dart:developer';

import 'package:buzz_buddy/controller/utils/api_urls.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserRepo {
  static var client = http.Client();
  //Fetch loggedIn user posts
  static Future<Response?> fetchUserPosts({String? userId}) async {
    try {
      final loggineduserId = await getUserId();
      if (kDebugMode) {
        print(loggineduserId);
      }
      var response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId'));
      if (kDebugMode) {
        print(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId');
      }
      // debugPrint(response.statusCode.toString());
      // debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
  //Fetch loggedIn user details
  static Future fetchLoggedInUserDetails() async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.logginedUser}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
  //fetchsuggession user
  static Future<Response?> fetchSuggessionUser() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.suggessions}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

import 'dart:convert';
import 'dart:core';

import 'package:buzz_buddy/controller/utils/api_urls.dart';
import 'package:buzz_buddy/model/user_model.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthenticationRepo {
  static var client = http.Client();
  Future<Response?> sentOtp(UserModel user) async {
    if (kDebugMode) {
      // print(user.emailId);
    }
    var data = {
      "userName": user.userName,
      "email": user.emailId,
      "password": user.password,
      "phone": user.phoneNumber
    };
    var jsonData = jsonEncode(data);

    try {
      // debugPrint('_________');
      final response = await client.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.signUp),
        body: jsonData,
        headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },
      );
      // debugPrint(response.toString());
      return response;
    } catch (e) {
      debugPrint('+++++++++');
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> verifyOtp(String email, String otp) async {
    var data = {'email': email, 'otp': otp};

    try {
      var response = await client.post(
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.verifyOtp),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json",
        },
      );
      debugPrint(response.body);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> userLogin(String email, String password) async {
    try {
      var user = {'email': email, 'password': password};
      var response = await client.post(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.login),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      debugPrint(response.statusCode.toString());
      if (kDebugMode) {
        print(user);
      }
      debugPrint(response.body);
      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await setUserLoggedin(
          token: responseBody['user']['token'],
          userrole: responseBody['user']['role'],
          userid: responseBody['user']['_id'],
          userEmail: responseBody['user']['email'],
          userName: responseBody['user']['userName'],
          userprofile: responseBody['user']['profilePic'],
        );
        return response;
      } else {
        return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?> resetPassSendOtp(String email) async {
    try {
      Response? response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl + ApiEndpoints.forgotPassword}$email'));
      // print('${ApiEndpoints.baseUrl+ApiEndpoints.forgotPassword}$email');
      if (kDebugMode) {
        print(response.body);
      }

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> verifyOtpPasswordReset(
      String email, String otp) async {
    try {
      var response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl + ApiEndpoints.verifyOtpReset}$email&otp=$otp'));
      // print(response.body);
      //  print('${ApiEndpoints.baseUrl+ApiEndpoints.verifyOtpReset}$email&otp=$otp');
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> updatePassword(String email, String password) async {
    try {
      var user = {'email': email, 'password': password};
      var response = await client.patch(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.updatePassword),
          body: jsonEncode(user),
          headers: {"Content-Type": 'application/json'});
      if (kDebugMode) {
        print(response.body);
      }
      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> googleLogin(String email) async {
    try {
      // print('9999999');
      final finalEmail = {'email': email};
      var response = await client.post(
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.googleLogin),
          body: jsonEncode(finalEmail),
          headers: {"Content-Type": 'application/json'});
      // print(ApiEndpoints.baseUrl+ApiEndpoints.googleLogin);
      // print(response.body);
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // print(responseBody);
        await setUserLoggedin(
          token: responseBody['user']['token'],
          userrole: responseBody['user']['role'],
          userid: responseBody['user']['_id'],
          userEmail: responseBody['user']['email'],
          userName: responseBody['user']['userName'],
          userprofile: responseBody['user']['profilePic'],
        );
      }
      return response;
    } catch (e) {
      return null;
    }
  }
}

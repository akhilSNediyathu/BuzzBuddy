
import 'dart:convert';
import 'dart:core';


import 'package:buzz_buddy/controller/utils/api_urls.dart';
import 'package:buzz_buddy/model/user_model.dart';
import 'package:buzz_buddy/utils/functions.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class AuthenticationRepo{
  static var client = http.Client();
   Future <Response?>  sentOtp(UserModel user )async{
    if (kDebugMode) {
      // print(user.emailId);
    }
    var data = 
      {
    "userName": user.userName,
    "email":user.emailId,
    "password":user.password,
    "phone":user.phoneNumber

};
var jsonData = jsonEncode(data);

try {
  // debugPrint('_________');
  final response = await client.post(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.signUp),body: jsonData,headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },);
        // debugPrint(response.toString());
    return response;
  
} catch (e) {
  debugPrint('+++++++++');
  debugPrint(e.toString());
  return null;
  
}



    
    
   }

static Future <Response?> verifyOtp(String email, String otp)async{
    var data = {'email': email, 'otp': otp};
   
 try {
      var response = await client.post(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.verifyOtp),body: jsonEncode(data),headers:{
          "Content-Type": "application/json", 
        }, );
        debugPrint(response.body);
        return response;
 } catch (e) {
   debugPrint(e.toString());
   return null;
 }

  }
  static Future <Response?>userLogin( String email , String password)async{
    try {
      var user = { 'email': email,'password':password};
      var response = await client.post(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.login),body:jsonEncode(user),headers: {"Content-Type": 'application/json'});
       debugPrint(response.statusCode.toString());
       print(user);
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

}
import 'dart:convert';

import 'package:buzz_buddy/controller/utils/api_urls.dart';
import 'package:buzz_buddy/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

class AuthenticationRepo{
  static var client = http.Client();
   Future <Response?> sentOtp(UserModel user )async{
    print(user.emailId);
    var data = 
      {
    "userName": user.userName,
    "email":user.emailId,
    "password":user.password,
    "phone":user.phoneNumber

};
var jsonData = jsonEncode(data);

try {
  print('_________');
  final response = await client.post(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.signUp),body: jsonData,headers: {
          "Content-Type": "application/json", // Set the content type to JSON
        },);
        print(response);
    return response;
  
} catch (e) {
  print('+++++++++');
  print(e);
  return null;
  
}



    
    
   }

 Future <Response?> verifyOtp(String email, String otp)async{
    var data = {'email': email, 'otp': otp};
    client = http.Client();
 try {
      var response = await client.post(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.verifyOtp),body: jsonEncode(data),headers:{
          "Content-Type": "application/json", // Set the content type to JSON
        }, );
        debugPrint(response.body);
        return response;
 } catch (e) {
   debugPrint(e.toString());
   return null;
 }

  }

}
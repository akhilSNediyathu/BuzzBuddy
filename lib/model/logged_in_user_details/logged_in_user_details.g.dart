// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_in_user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedInUserDetails _$LoggedInUserDetailsFromJson(Map<String, dynamic> json) =>
    LoggedInUserDetails(
      id: json['_id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      profilePic: json['profilePic'] as String?,
      online: json['online'] as bool?,
      phone: json['phone'] as String?,
      blocked: json['blocked'] as bool?,
      verified: json['verified'] as bool?,
      role: json['role'] as String?,
      backGroundImage: json['backGroundImage'] as String?,
      isPrivate: json['isPrivate'] as bool?,
    );

Map<String, dynamic> _$LoggedInUserDetailsToJson(
        LoggedInUserDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'token': instance.token,
      'profilePic': instance.profilePic,
      'online': instance.online,
      'phone': instance.phone,
      'blocked': instance.blocked,
      'verified': instance.verified,
      'role': instance.role,
      'backGroundImage': instance.backGroundImage,
      'isPrivate': instance.isPrivate,
    };

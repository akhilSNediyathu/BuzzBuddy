import 'dart:convert';

// UserModel class representing the user data
class UserModel {
  String id;
  String userName;
  String email;
  String password;
  String profilePic;
  bool online;
  bool blocked;
  bool verified;
  String role;
  bool isPrivate;
  String backGroundImage;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? bio;
  String? name;
  String? phone;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.backGroundImage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.bio,
    this.name,
    this.phone,
  });

  // Factory constructor to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      backGroundImage: json['backGroundImage'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      bio: json['bio'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  // Method to convert a UserModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userName': userName,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'online': online,
      'blocked': blocked,
      'verified': verified,
      'role': role,
      'isPrivate': isPrivate,
      'backGroundImage': backGroundImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'bio': bio,
      'name': name,
      'phone': phone,
    };
  }
}

// PostModel class representing the post data
class FollowersPostModel {
  String id;
  UserModel userId;
  String image;
  String description;
  List<dynamic> likes;
  bool hidden;
  bool blocked;
  List<dynamic> tags;
  List<dynamic> taggedUsers;
  DateTime date;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isLiked;
  bool isSaved;

  FollowersPostModel({
    required this.id,
    required this.userId,
    required this.image,
    required this.description,
    required this.likes,
    required this.hidden,
    required this.blocked,
    required this.tags,
    required this.taggedUsers,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
    required this.isSaved,
  });

  // Factory constructor to create a PostModel instance from JSON
  factory FollowersPostModel.fromJson(Map<String, dynamic> json) {
    return FollowersPostModel(
      id: json['_id'],
      userId: UserModel.fromJson(json['userId']),
      image: json['image'],
      description: json['description'],
      likes: List<dynamic>.from(json['likes']),
      hidden: json['hidden'],
      blocked: json['blocked'],
      tags: List<dynamic>.from(json['tags']),
      taggedUsers: List<dynamic>.from(json['taggedUsers']),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      isLiked: json['isLiked'],
      isSaved: json['isSaved'],
    );
  }

  // Method to convert a PostModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId.toJson(),
      'image': image,
      'description': description,
      'likes': likes,
      'hidden': hidden,
      'blocked': blocked,
      'tags': tags,
      'taggedUsers': taggedUsers,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'isLiked': isLiked,
      'isSaved': isSaved,
    };
  }
}
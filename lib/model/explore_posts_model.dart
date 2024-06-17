class ExplorePostModel {
  final String id;
  final UserModel userId;
  final String image;
  final String description;
  final List<dynamic> likes;
  final bool hidden;
  final bool blocked;
  final List<dynamic> tags;
  final List<dynamic> taggedUsers;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExplorePostModel({
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
  });

  factory ExplorePostModel.fromJson(Map<String, dynamic> json) {
    return ExplorePostModel(
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
    );
  }
}

class UserModel {
  final String id;
  final String userName;
  final String email;
  final String profilePic;
  // other fields...

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.profilePic,
    // other fields...
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      profilePic: json['profilePic'],
      // other fields...
    );
  }
}

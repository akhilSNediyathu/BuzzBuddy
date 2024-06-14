import 'package:json_annotation/json_annotation.dart';
part 'logged_in_user_details.g.dart';

@JsonSerializable()
class LoggedInUserDetails {
  @JsonKey(name: '_id')
  String? id;
  String? userName;
  String? email;
  String? token;
  String? profilePic;
  bool? online;
  String? phone;
  bool? blocked;
  bool? verified;
  String? role;
  String? backGroundImage;
  bool? isPrivate;

  LoggedInUserDetails({
    this.id,
    this.userName,
    this.email,
    this.token,
    this.profilePic,
    this.online,
    this.phone,
    this.blocked,
    this.verified,
    this.role,
    this.backGroundImage,
    this.isPrivate,
  });

  factory LoggedInUserDetails.fromJson(Map<String, dynamic> json) {
    return _$LoggedInUserDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoggedInUserDetailsToJson(this);
}

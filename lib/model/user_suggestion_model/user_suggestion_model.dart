import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

 part 'user_suggestion_model.g.dart';

@JsonSerializable()
class UserSuggestionModel {
  List<Datum>? data;
  int? total;

  UserSuggestionModel({this.data, this.total});

  factory UserSuggestionModel.fromJson(Map<String, dynamic> json) {
    return _$UserSuggestionModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserSuggestionModelToJson(this);
}

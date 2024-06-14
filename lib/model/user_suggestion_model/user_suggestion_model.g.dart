// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSuggestionModel _$UserSuggestionModelFromJson(Map<String, dynamic> json) =>
    UserSuggestionModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserSuggestionModelToJson(
        UserSuggestionModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'total': instance.total,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_agent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingAgent _$RatingAgentFromJson(Map<String, dynamic> json) => RatingAgent(
      agent: json['agent'] as String?,
      user: json['user'] as String?,
      ratings: (json['ratings'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RatingAgentToJson(RatingAgent instance) =>
    <String, dynamic>{
      'agent': instance.agent,
      'user': instance.user,
      'ratings': instance.ratings,
    };

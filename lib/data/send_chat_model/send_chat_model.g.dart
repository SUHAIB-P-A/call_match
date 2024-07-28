// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendChatModel _$SendChatModelFromJson(Map<String, dynamic> json) =>
    SendChatModel(
      user1: json['user_1'] as String?,
      user2: json['user_2'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SendChatModelToJson(SendChatModel instance) =>
    <String, dynamic>{
      'user_1': instance.user1,
      'user_2': instance.user2,
      'message': instance.message,
    };

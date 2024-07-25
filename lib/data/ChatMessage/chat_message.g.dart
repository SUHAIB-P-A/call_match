// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      messageId: (json['message_id'] as num?)?.toInt(),
      sender: json['sender'] == null
          ? null
          : LoginedUser.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : LoginedUser.fromJson(json['receiver'] as Map<String, dynamic>),
      message: json['message'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'message': instance.message,
      'created_at': instance.createdAt,
    };

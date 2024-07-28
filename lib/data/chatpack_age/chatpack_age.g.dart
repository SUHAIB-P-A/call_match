// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatpack_age.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatpackAge _$ChatpackAgeFromJson(Map<String, dynamic> json) => ChatpackAge(
      chatId: (json['chat_id'] as num?)?.toInt(),
      packagePrice: (json['package_price'] as num?)?.toInt(),
      messageCount: (json['message_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ChatpackAgeToJson(ChatpackAge instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'package_price': instance.packagePrice,
      'message_count': instance.messageCount,
    };

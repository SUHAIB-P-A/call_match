// chat_message.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:call_match/data/logined_user/logined_user.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  @JsonKey(name: 'message_id')
  int? messageId;
  @JsonKey(name: 'sender')
  LoginedUser? sender;
  @JsonKey(name: 'receiver')
  LoginedUser? receiver;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'created_at')
  String? createdAt;

  ChatMessage({
    this.messageId,
    this.sender,
    this.receiver,
    this.message,
    this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  // Factory method for converting a list of maps to a list of ChatMessage objects
  static List<ChatMessage> listFromJson(List<dynamic> jsonList) => jsonList
      .map((json) => ChatMessage.fromJson(json as Map<String, dynamic>))
      .toList();

  // Method for converting a list of ChatMessage objects to a list of maps
  static List<Map<String, dynamic>> listToJson(
          List<ChatMessage> chatMessageList) =>
      chatMessageList.map((chatMessage) => chatMessage.toJson()).toList();
}

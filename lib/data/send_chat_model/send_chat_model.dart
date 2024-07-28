import 'package:json_annotation/json_annotation.dart';

part 'send_chat_model.g.dart';

@JsonSerializable()
class SendChatModel {
  @JsonKey(name: 'user_1')
  String? user1;
  @JsonKey(name: 'user_2')
  String? user2;
  @JsonKey(name: 'message')
  String? message;

  SendChatModel({this.user1, this.user2, this.message});
  SendChatModel.create({
    required this.user1,
    required this.user2,
    required this.message,
  });

  factory SendChatModel.fromJson(Map<String, dynamic> json) {
    return _$SendChatModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SendChatModelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'chatpack_age.g.dart';

@JsonSerializable()
class ChatpackAge {
  @JsonKey(name: 'chat_id')
  int? chatId;
  @JsonKey(name: 'package_price')
  int? packagePrice;
  @JsonKey(name: 'message_count')
  int? messageCount;

  ChatpackAge({this.chatId, this.packagePrice, this.messageCount});

  factory ChatpackAge.fromJson(Map<String, dynamic> json) {
    return _$ChatpackAgeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatpackAgeToJson(this);
}

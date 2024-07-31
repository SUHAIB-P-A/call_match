import 'package:json_annotation/json_annotation.dart';

part 'start_call.g.dart';

@JsonSerializable()
class StartCall {
  @JsonKey(name: 'caller_id')
  String? callerId;
  @JsonKey(name: 'agent_id')
  String? agentId;
  @JsonKey(name: 'agora_channel_name')
  String? agoraChannelName;

  StartCall({this.callerId, this.agentId, this.agoraChannelName});

  StartCall.create({
    required this.callerId,
    required this.agentId,
    required this.agoraChannelName,
  });

  factory StartCall.fromJson(Map<String, dynamic> json) {
    return _$StartCallFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StartCallToJson(this);
}

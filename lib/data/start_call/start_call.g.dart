// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartCall _$StartCallFromJson(Map<String, dynamic> json) => StartCall(
      callerId: json['caller_id'] as String?,
      agentId: json['agent_id'] as String?,
      agoraChannelName: json['agora_channel_name'] as String?,
    );

Map<String, dynamic> _$StartCallToJson(StartCall instance) => <String, dynamic>{
      'caller_id': instance.callerId,
      'agent_id': instance.agentId,
      'agora_channel_name': instance.agoraChannelName,
    };

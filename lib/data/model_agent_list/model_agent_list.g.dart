// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_agent_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelAgentList _$ModelAgentListFromJson(Map<String, dynamic> json) =>
    ModelAgentList(
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerFirstName: json['customer_first_name'] as String?,
      customerLastName: json['customer_last_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerContact: json['customer_contact'] as String?,
      status: json['status'] as String?,
      isOnline: json['is_online'] as bool?,
      languages: json['languages'] as String?,
    );

Map<String, dynamic> _$ModelAgentListToJson(ModelAgentList instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'customer_first_name': instance.customerFirstName,
      'customer_last_name': instance.customerLastName,
      'customer_email': instance.customerEmail,
      'customer_contact': instance.customerContact,
      'status': instance.status,
      'is_online': instance.isOnline,
      'languages': instance.languages,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelUserList _$ModelUserListFromJson(Map<String, dynamic> json) =>
    ModelUserList(
      customerId: (json['customer_id'] as num?)?.toInt(),
      customerFirstName: json['customer_first_name'] as String?,
      customerLastName: json['customer_last_name'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerContact: json['customer_contact'] as String?,
      status: json['status'] as String?,
      isOnline: json['is_online'] as bool?,
      languages: json['languages'] as String?,
      isExisting: json['is_existing'] as bool?,
      adhaarNo: json['adhaar_no'] as String?,
    );

Map<String, dynamic> _$ModelUserListToJson(ModelUserList instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'customer_first_name': instance.customerFirstName,
      'customer_last_name': instance.customerLastName,
      'customer_email': instance.customerEmail,
      'customer_contact': instance.customerContact,
      'status': instance.status,
      'is_online': instance.isOnline,
      'languages': instance.languages,
      'is_existing': instance.isExisting,
      'adhaar_no': instance.adhaarNo,
    };

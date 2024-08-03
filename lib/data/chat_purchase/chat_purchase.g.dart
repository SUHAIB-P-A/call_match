// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatPurchase _$ChatPurchaseFromJson(Map<String, dynamic> json) => ChatPurchase(
      userId: json['user_id'] as String?,
      packageId: json['package_id'] as String?,
      razorpayPaymentId: json['razorpay_payment_id'] as String?,
    );

Map<String, dynamic> _$ChatPurchaseToJson(ChatPurchase instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'package_id': instance.packageId,
      'razorpay_payment_id': instance.razorpayPaymentId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallPurchase _$CallPurchaseFromJson(Map<String, dynamic> json) => CallPurchase(
      userId: json['user_id'] as String?,
      packageId: json['package_id'] as String?,
      razorpayPaymentId: json['razorpay_payment_id'] as String?,
    );

Map<String, dynamic> _$CallPurchaseToJson(CallPurchase instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'package_id': instance.packageId,
      'razorpay_payment_id': instance.razorpayPaymentId,
    };

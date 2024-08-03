import 'package:json_annotation/json_annotation.dart';

part 'call_purchase.g.dart';

@JsonSerializable()
class CallPurchase {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'package_id')
  String? packageId;
  @JsonKey(name: 'razorpay_payment_id')
  String? razorpayPaymentId;

  CallPurchase({this.userId, this.packageId, this.razorpayPaymentId});

  CallPurchase.create({
    required this.userId,
    required this.packageId,
    required this.razorpayPaymentId,
  });

  factory CallPurchase.fromJson(Map<String, dynamic> json) {
    return _$CallPurchaseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CallPurchaseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'chat_purchase.g.dart';

@JsonSerializable()
class ChatPurchase {
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'package_id')
  String? packageId;
  @JsonKey(name: 'razorpay_payment_id')
  String? razorpayPaymentId;

  ChatPurchase({this.userId, this.packageId, this.razorpayPaymentId});

  ChatPurchase.create({
    required this.userId,
    required this.packageId,
    required this.razorpayPaymentId,
  });

  factory ChatPurchase.fromJson(Map<String, dynamic> json) {
    return _$ChatPurchaseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChatPurchaseToJson(this);
}

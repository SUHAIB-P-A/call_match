import 'package:json_annotation/json_annotation.dart';

part 'wallet_details.g.dart';

@JsonSerializable()
class WalletDetails {
  @JsonKey(name: 'wallet_id')
  int? walletId;
  @JsonKey(name: 'wallet_coins')
  int? walletCoins;
  @JsonKey(name: 'messages_remaining')
  int? messagesRemaining;
  @JsonKey(name: 'call_amount')
  double? callAmount;
  @JsonKey(name: 'chat_amount')
  int? chatAmount;
  @JsonKey(name: 'total_messages_received')
  int? totalMessagesReceived;
  @JsonKey(name: 'total_minutes')
  int? totalMinutes;
  @JsonKey(name: 'user')
  int? user;

  WalletDetails({
    this.walletId,
    this.walletCoins,
    this.messagesRemaining,
    this.callAmount,
    this.chatAmount,
    this.totalMessagesReceived,
    this.totalMinutes,
    this.user,
  });

  factory WalletDetails.fromJson(Map<String, dynamic> json) =>
      _$WalletDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDetailsToJson(this);

  // Factory method for converting a list of maps to a list of WalletDetails objects
  static List<WalletDetails> listFromJson(List<dynamic> jsonList) => jsonList
      .map((json) => WalletDetails.fromJson(json as Map<String, dynamic>))
      .toList();

  // Method for converting a list of WalletDetails objects to a list of maps
  static List<Map<String, dynamic>> listToJson(
          List<WalletDetails> walletDetailsList) =>
      walletDetailsList.map((walletDetails) => walletDetails.toJson()).toList();
}

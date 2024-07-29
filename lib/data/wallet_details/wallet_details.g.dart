// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletDetails _$WalletDetailsFromJson(Map<String, dynamic> json) =>
    WalletDetails(
      walletId: (json['wallet_id'] as num?)?.toInt(),
      walletCoins: (json['wallet_coins'] as num?)?.toInt(),
      messagesRemaining: (json['messages_remaining'] as num?)?.toInt(),
      callAmount: (json['call_amount'] as num?)?.toDouble(),
      chatAmount: (json['chat_amount'] as num?)?.toInt(),
      totalMessagesReceived: (json['total_messages_received'] as num?)?.toInt(),
      totalMinutes: (json['total_minutes'] as num?)?.toInt(),
      totalamount: (json['total_amount'] as num?)?.toInt(),
      user: (json['user'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WalletDetailsToJson(WalletDetails instance) =>
    <String, dynamic>{
      'wallet_id': instance.walletId,
      'wallet_coins': instance.walletCoins,
      'messages_remaining': instance.messagesRemaining,
      'call_amount': instance.callAmount,
      'chat_amount': instance.chatAmount,
      'total_messages_received': instance.totalMessagesReceived,
      'total_minutes': instance.totalMinutes,
      'total_amount': instance.totalamount,
      'user': instance.user,
    };

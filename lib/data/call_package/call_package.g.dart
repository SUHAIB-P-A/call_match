// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallPackage _$CallPackageFromJson(Map<String, dynamic> json) => CallPackage(
      coinId: (json['coin_id'] as num?)?.toInt(),
      packagePrice: (json['package_price'] as num?)?.toInt(),
      totalCoins: (json['total_coins'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CallPackageToJson(CallPackage instance) =>
    <String, dynamic>{
      'coin_id': instance.coinId,
      'package_price': instance.packagePrice,
      'total_coins': instance.totalCoins,
    };

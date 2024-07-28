import 'package:json_annotation/json_annotation.dart';

part 'call_package.g.dart';

@JsonSerializable()
class CallPackage {
  @JsonKey(name: 'coin_id')
  int? coinId;
  @JsonKey(name: 'package_price')
  int? packagePrice;
  @JsonKey(name: 'total_coins')
  int? totalCoins;

  CallPackage({this.coinId, this.packagePrice, this.totalCoins});

  factory CallPackage.fromJson(Map<String, dynamic> json) {
    return _$CallPackageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CallPackageToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'model_user_list.g.dart';

@JsonSerializable()
class ModelUserList {
  @JsonKey(name: 'customer_id')
  int? customerId;
  @JsonKey(name: 'customer_first_name')
  String? customerFirstName;
  @JsonKey(name: 'customer_last_name')
  String? customerLastName;
  @JsonKey(name: 'customer_email')
  String? customerEmail;
  @JsonKey(name: 'customer_contact')
  String? customerContact;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'is_online')
  bool? isOnline;
  @JsonKey(name: 'languages')
  String? languages;
  @JsonKey(name: 'is_existing')
  bool? isExisting;
  @JsonKey(name: 'adhaar_no')
  String? adhaarNo;

  ModelUserList({
    this.customerId,
    this.customerFirstName,
    this.customerLastName,
    this.customerEmail,
    this.customerContact,
    this.status,
    this.isOnline,
    this.languages,
    this.isExisting,
    this.adhaarNo,
  });

  factory ModelUserList.fromJson(Map<String, dynamic> json) {
    return _$ModelUserListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ModelUserListToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'logined_user.g.dart';

@JsonSerializable()
class LoginedUser {
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

  LoginedUser({
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
  LoginedUser.create({
    this.customerId,
    required this.customerFirstName,
    required this.customerLastName,
    required this.customerEmail,
    this.customerContact,
    this.status,
    this.isOnline,
    this.languages,
    this.isExisting,
    this.adhaarNo,
  });
  factory LoginedUser.fromJson(Map<String, dynamic> json) {
    return _$LoginedUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginedUserToJson(this);

  // Factory method for converting a list of maps to a list of logineduser objects
  static List<LoginedUser> listFromJson(List<dynamic> jsonList) => jsonList
      .map((json) => LoginedUser.fromJson(json as Map<String, dynamic>))
      .toList();

  // Method for converting a list of logineduser objects to a list of maps
  static List<Map<String, dynamic>> listToJson(
          List<LoginedUser> logineduserList) =>
      logineduserList.map((loginedUser) => loginedUser.toJson()).toList();
}

import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:json_annotation/json_annotation.dart';


part 'login_with_number.g.dart';

@JsonSerializable()
class LoginWithNumber {
  @JsonKey(name: 'mobile_no')
  String? mobileNo;

  @JsonKey(
      name: 'user', fromJson: _loginedUserFromJson, toJson: _loginedUserToJson)
  LoginedUser? user;

  LoginWithNumber({this.mobileNo, this.user});

  factory LoginWithNumber.fromJson(Map<String, dynamic> json) {
    return _$LoginWithNumberFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginWithNumberToJson(this);
}

// Custom fromJson and toJson functions
LoginedUser? _loginedUserFromJson(Map<String, dynamic>? json) {
  return json == null ? null : LoginedUser.fromJson(json);
}

Map<String, dynamic>? _loginedUserToJson(LoginedUser? user) {
  return user?.toJson();
}

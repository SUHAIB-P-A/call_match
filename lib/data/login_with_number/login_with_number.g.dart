// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithNumber _$LoginWithNumberFromJson(Map<String, dynamic> json) =>
    LoginWithNumber(
      mobileNo: json['mobile_no'] as String?,
      user: _loginedUserFromJson(json['user'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$LoginWithNumberToJson(LoginWithNumber instance) =>
    <String, dynamic>{
      'mobile_no': instance.mobileNo,
      'user': _loginedUserToJson(instance.user),
    };

import 'package:json_annotation/json_annotation.dart';

part 'model_agent_list.g.dart';

@JsonSerializable()
class ModelAgentList {
  @JsonKey(name: 'customer_id')
  int? customerId;
  @JsonKey(name: 'rating')
  int? rating;
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
  @JsonKey(name: 'terms_conditions')
  bool? termsConditions;

  ModelAgentList({
    this.customerId,
    this.rating,
    this.customerFirstName,
    this.customerLastName,
    this.customerEmail,
    this.customerContact,
    this.status,
    this.isOnline,
    this.languages,
    this.termsConditions,
  });

  factory ModelAgentList.fromJson(Map<String, dynamic> json) {
    return _$ModelAgentListFromJson(json);
  }

  get firstName => null;

  get lastName => null;

  get uid => null;

  get location => null;

  get category => null;

  Map<String, dynamic> toJson() => _$ModelAgentListToJson(this);
}

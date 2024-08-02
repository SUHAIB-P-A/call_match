import 'package:json_annotation/json_annotation.dart';

part 'rating_agent.g.dart';

@JsonSerializable()
class RatingAgent {
  @JsonKey(name: 'agent')
  String? agent;
  @JsonKey(name: 'user')
  String? user;
  @JsonKey(name: 'ratings')
  int? ratings;

  RatingAgent({this.agent, this.user, this.ratings});
  RatingAgent.create({
    required this.agent,
    required this.user,
    required this.ratings,
  });
  factory RatingAgent.fromJson(Map<String, dynamic> json) {
    return _$RatingAgentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RatingAgentToJson(this);
}

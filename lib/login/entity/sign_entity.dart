import 'package:json_annotation/json_annotation.dart';
part 'sign_entity.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class SignEntity {
  @JsonKey(name: "sign")
  String? sign;
  @JsonKey(name: "publicKey")
  String? publicKey;

  SignEntity({this.sign, this.publicKey});

  factory SignEntity.fromJson(Map<String, dynamic> json) =>
      _$SignEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SignEntityToJson(this);
}

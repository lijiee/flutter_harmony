import 'package:json_annotation/json_annotation.dart';

part 'login_name.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class LoginName {
  final String? name;

  const LoginName({
    this.name,
  });

  factory LoginName.fromJson(Map<String, dynamic> json) =>
      _$LoginNameFromJson(json);

  Map<String, dynamic> toJson() => _$LoginNameToJson(this);
}

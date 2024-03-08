import 'package:json_annotation/json_annotation.dart';

part 'version_check_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class VersionCheckEntity {
  final String? lastVersion;
  final int? lastCode;
  final int? reminderBeginTime;
  final int? auditStatus;
  final int? promptUpdateInterval;
  final int? updateType;
  final dynamic downloadType;
  final String? downloadUrl;
  final List<HistoryVersions>? historyVersions;

  const VersionCheckEntity({
    this.lastVersion,
    this.lastCode,
    this.reminderBeginTime,
    this.auditStatus,
    this.promptUpdateInterval,
    this.updateType,
    this.downloadType,
    this.downloadUrl,
    this.historyVersions,
  });

  factory VersionCheckEntity.fromJson(Map<String, dynamic> json) =>
      _$VersionCheckEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VersionCheckEntityToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.none)
class HistoryVersions {
  final String? version;
  final String? updateDescription;

  const HistoryVersions({
    this.version,
    this.updateDescription,
  });

  factory HistoryVersions.fromJson(Map<String, dynamic> json) =>
      _$HistoryVersionsFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryVersionsToJson(this);
}

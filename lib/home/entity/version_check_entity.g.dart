// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_check_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionCheckEntity _$VersionCheckEntityFromJson(Map<String, dynamic> json) =>
    VersionCheckEntity(
      lastVersion: json['lastVersion'] as String?,
      lastCode: json['lastCode'] as int?,
      reminderBeginTime: json['reminderBeginTime'] as int?,
      auditStatus: json['auditStatus'] as int?,
      promptUpdateInterval: json['promptUpdateInterval'] as int?,
      updateType: json['updateType'] as int?,
      downloadType: json['downloadType'],
      downloadUrl: json['downloadUrl'] as String?,
      historyVersions: (json['historyVersions'] as List<dynamic>?)
          ?.map((e) => HistoryVersions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VersionCheckEntityToJson(VersionCheckEntity instance) =>
    <String, dynamic>{
      'lastVersion': instance.lastVersion,
      'lastCode': instance.lastCode,
      'reminderBeginTime': instance.reminderBeginTime,
      'auditStatus': instance.auditStatus,
      'promptUpdateInterval': instance.promptUpdateInterval,
      'updateType': instance.updateType,
      'downloadType': instance.downloadType,
      'downloadUrl': instance.downloadUrl,
      'historyVersions': instance.historyVersions,
    };

HistoryVersions _$HistoryVersionsFromJson(Map<String, dynamic> json) =>
    HistoryVersions(
      version: json['version'] as String?,
      updateDescription: json['updateDescription'] as String?,
    );

Map<String, dynamic> _$HistoryVersionsToJson(HistoryVersions instance) =>
    <String, dynamic>{
      'version': instance.version,
      'updateDescription': instance.updateDescription,
    };

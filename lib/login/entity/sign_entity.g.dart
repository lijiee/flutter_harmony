// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignEntity _$SignEntityFromJson(Map<String, dynamic> json) => SignEntity(
      sign: json['sign'] as String?,
      publicKey: json['publicKey'] as String?,
    );

Map<String, dynamic> _$SignEntityToJson(SignEntity instance) =>
    <String, dynamic>{
      'sign': instance.sign,
      'publicKey': instance.publicKey,
    };

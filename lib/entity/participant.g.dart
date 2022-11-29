// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      timeStamp:
          const DateTimeConverter().fromJson(json['Timestamp'] as String),
      email: json['Địa chỉ email đăng ký Online Codelab Challenge'] as String,
      joinedCodelab: json['Chủ đề Codelab tham gia'] as String,
      receiveCertMethod: json['Hình thức nhận Giấy chứng nhận'] as String,
      publicProfile: json['Link public Profile Cloud Skill Boots'] as String,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'Timestamp': const DateTimeConverter().toJson(instance.timeStamp),
      'Địa chỉ email đăng ký Online Codelab Challenge': instance.email,
      'Chủ đề Codelab tham gia': instance.joinedCodelab,
      'Hình thức nhận Giấy chứng nhận': instance.receiveCertMethod,
      'Link public Profile Cloud Skill Boots': instance.publicProfile,
    };

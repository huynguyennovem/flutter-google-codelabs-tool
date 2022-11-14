// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
      timeStamp:
          const DateTimeConverter().fromJson(json['Timestamp'] as String),
      email: json['Your email'] as String,
      joinedCodelab: json['Joined codelab'] as String,
      receiveCertMethod: json['How to get a certificate'] as String,
      publicProfile: json['Link public profile'] as String,
    );

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'Timestamp': const DateTimeConverter().toJson(instance.timeStamp),
      'Your email': instance.email,
      'Joined codelab': instance.joinedCodelab,
      'How to get a certificate': instance.receiveCertMethod,
      'Link public profile': instance.publicProfile,
    };

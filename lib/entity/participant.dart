import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'badge.dart';
import 'datetime_converter.dart';

part 'participant.g.dart';

@JsonSerializable()
@DateTimeConverter()
class Participant extends Equatable {
  @JsonKey(name: 'Timestamp')
  final DateTime timeStamp;

  @JsonKey(name: 'Địa chỉ email đăng ký Online Codelab Challenge')
  final String email;

  @JsonKey(name: 'Chủ đề Codelab tham gia')
  final String joinedCodelab;

  @JsonKey(name: 'Hình thức nhận Giấy chứng nhận')
  final String receiveCertMethod;

  @JsonKey(name: 'Link public Profile Cloud Skill Boots')
  final String publicProfile;

  // These below properties will be updated when handling final result,
  // right after appScriptUrl query finished

  @JsonKey(ignore: true)
  final List<Badge>? badges;

  const Participant({
    required this.timeStamp,
    required this.email,
    required this.joinedCodelab,
    required this.receiveCertMethod,
    required this.publicProfile,
    this.badges,
  });

  factory Participant.fromJson(Map<String, dynamic> data) => _$ParticipantFromJson(data);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);

  Participant copyWith({
    DateTime? timeStamp,
    String? email,
    String? joinedCodelab,
    String? receiveCertMethod,
    String? publicProfile,
    List<Badge>? badges,
  }) {
    return Participant(
      timeStamp: timeStamp ?? this.timeStamp,
      email: email ?? this.email,
      joinedCodelab: joinedCodelab ?? this.joinedCodelab,
      receiveCertMethod: receiveCertMethod ?? this.receiveCertMethod,
      publicProfile: publicProfile ?? this.publicProfile,
      badges: badges ?? this.badges,
    );
  }

  @override
  List<Object?> get props => [
        timeStamp,
        email,
        joinedCodelab,
        receiveCertMethod,
        publicProfile,
        badges,
      ];
}

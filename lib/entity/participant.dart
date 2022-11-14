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

  @JsonKey(name: 'Your email')
  final String email;

  @JsonKey(name: 'Joined codelab')
  final String joinedCodelab;

  @JsonKey(name: 'How to get a certificate')
  final String receiveCertMethod;

  @JsonKey(name: 'Link public profile')
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

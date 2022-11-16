import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';

class ParticipantProvider extends ChangeNotifier {
  List<Participant> _participants = [];

  List<Participant> get participants => _participants;

  void addParticipant({required Participant participant}) {
    _participants.add(participant);
    notifyListeners();
  }

  void addAllParticipants({required List<Participant> participants}) {
    _participants.clear();
    _participants.addAll(participants);
    notifyListeners();
  }

}

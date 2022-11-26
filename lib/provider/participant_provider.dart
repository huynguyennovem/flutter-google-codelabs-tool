import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/order_type.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sort_type.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sorter.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';

class ParticipantProvider extends ChangeNotifier {
  List<Participant> _participants = [];

  List<Participant> get participants => _participants;

  Sorter _sorter = Sorter.init();

  Sorter get sorter => _sorter;

  void addParticipant({required Participant participant}) {
    _participants.add(participant);
    notifyListeners();
  }

  void addAllParticipants({required List<Participant> participants}) {
    _participants.clear();
    _participants.addAll(participants);
    notifyListeners();
  }

  void sortParticipants({required Sorter sorter}) {
    _sorter = sorter;
    switch (sorter.sortType) {
      case SortType.submittedTime:
        _participants.sort((a, b) {
          if (sorter.orderType == OrderType.desc) {
            return a.timeStamp.compareTo(b.timeStamp);
          } else {
            return b.timeStamp.compareTo(a.timeStamp);
          }
        });
        break;
      case SortType.fullName:
        if (sorter.orderType == OrderType.desc) {
          _participants.sort((a, b) {
            if (a.badges.nullOrEmpty) {
              if (b.badges.nullOrEmpty) {
                return 0;
              } else {
                return -1;
              }
            } else {
              if (b.badges.nullOrEmpty) {
                return 1;
              } else {
                return a.badges!.first.name.compareTo(b.badges!.first.name);
              }
            }
          });
        } else {
          _participants.sort((a, b) {
            if (a.badges.nullOrEmpty) {
              if (b.badges.nullOrEmpty) {
                return 0;
              } else {
                return 1;
              }
            } else {
              if (b.badges.nullOrEmpty) {
                return -1;
              } else {
                return b.badges!.first.name.compareTo(a.badges!.first.name);
              }
            }
          });
        }
        break;
      case SortType.numBadges:
        if (sorter.orderType == OrderType.desc) {
          _participants.sort((a, b) {
            if (a.badges.nullOrEmpty) {
              if (b.badges.nullOrEmpty) {
                return 0;
              } else {
                return -1;
              }
            } else {
              if (b.badges.nullOrEmpty) {
                return 1;
              } else {
                return a.badges!.length.compareTo(b.badges!.length);
              }
            }
          });
        } else {
          _participants.sort((a, b) {
            if (a.badges.nullOrEmpty) {
              if (b.badges.nullOrEmpty) {
                return 0;
              } else {
                return 1;
              }
            } else {
              if (b.badges.nullOrEmpty) {
                return -1;
              } else {
                return b.badges!.length.compareTo(a.badges!.length);
              }
            }
          });
        }
        break;
    }
    notifyListeners();
  }
}

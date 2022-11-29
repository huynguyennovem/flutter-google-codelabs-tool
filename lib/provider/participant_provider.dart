import 'package:flutter/material.dart';
import 'package:flutter_google_codelabs_tool/entity/quest/quest_stack.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/order_type.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sort_type.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:flutter_google_codelabs_tool/entity/sort/sorter.dart';
import 'package:flutter_google_codelabs_tool/util/constant.dart';
import 'package:flutter_google_codelabs_tool/util/extension.dart';

class ParticipantProvider extends ChangeNotifier {
  List<Participant> _participants = [];
  List<Participant> _originParticipants = [];

  List<Participant> get participants => _participants;
  List<Participant> get originParticipants => _originParticipants;

  Sorter _sorter = const Sorter.init();

  Sorter get sorter => _sorter;

  void addAllParticipants({required List<Participant> participants, bool useInitSorter = false}) {
    _participants.clear();
    _originParticipants.clear();

    _participants.addAll(participants);
    if (useInitSorter) {
      sortParticipants(sorter: const Sorter.init());
      _originParticipants.addAll(_participants);
      return;   // to prevent notifyListeners twice (already notified once in sortParticipants())
    } else {
      _originParticipants.addAll(_participants);
    }
    notifyListeners();
  }

  void sortParticipants({required Sorter sorter, bool needToNotify = true}) {
    _sorter = sorter;
    switch (sorter.sortType) {
      case SortType.submittedTime:
        _participants.sort((a, b) {
          if (sorter.orderType == OrderType.asc) {
            return a.timeStamp.compareTo(b.timeStamp);
          } else {
            return b.timeStamp.compareTo(a.timeStamp);
          }
        });
        break;
      case SortType.fullName:
        if (sorter.orderType == OrderType.asc) {
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
        if (sorter.orderType == OrderType.asc) {
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
      case SortType.completedTime:
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
                a.badges!.sort((b1, b2) => b2.earnedTime.compareTo(b1.earnedTime));
                final latestTimeA = a.badges![0].earnedTime;

                b.badges!.sort((b1, b2) => b2.earnedTime.compareTo(b1.earnedTime));
                final latestTimeB = b.badges![0].earnedTime;

                return latestTimeA.compareTo(latestTimeB);
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
                a.badges!.sort((b1, b2) => b2.earnedTime.compareTo(b1.earnedTime));
                final latestTimeA = a.badges![0].earnedTime;

                b.badges!.sort((b1, b2) => b2.earnedTime.compareTo(b1.earnedTime));
                final latestTimeB = b.badges![0].earnedTime;

                return latestTimeB.compareTo(latestTimeA);
              }
            }
          });
        }
        break;
    }
    if(needToNotify) {
      notifyListeners();
    }
  }

  // make sure to work on the original participant list
  // sometime, when user performs sorting or get other rewards first,
  // the participant list has been changed
  void resetDataToOrigin({required bool needNotify}) {
    _participants.clear();
    _participants.addAll(_originParticipants);
    if(needNotify) {
      notifyListeners();
    }
  }

  void getAwards({
    required QuestStack stack,
    required DateTimeRange validCodelabTime,
    required DateTimeRange validSubmitTime,
    int? numberParticipant,
  }) {
    resetDataToOrigin(needNotify: false);

    final listValidQuest = validQuests.listQuestName(stack: stack);
    final cloneParticipant = _participants.toList();   // prevent removing item in the loop issue
    for (var p in cloneParticipant) {

      // 1. filter participant by valid submit time
      final userSubmitTime = p.timeStamp;
      final isValidSubmitTime = userSubmitTime.isAfter(validSubmitTime.start) && userSubmitTime.isBefore(validSubmitTime.end);
      if(!isValidSubmitTime) {
        _participants.remove(p);
        continue;
      }

      // 2. filter participant by badges
      if (p.badges.nullOrEmpty) {
        _participants.remove(p);
        continue;
      }
      final validBadges = p.badges!.where((b) {
        // 2.1. filter participant by valid codelab name
        final validCodelab = listValidQuest.contains(b.name);

        // 2.2. filter participant by earned codelab time
        final earnedTime = b.earnedTime;
        final validTime = earnedTime.isAfter(validCodelabTime.start) && earnedTime.isBefore(validCodelabTime.end);

        return validCodelab && validTime;
      }).toList();

      if (validBadges.nullOrEmpty) {
        _participants.remove(p);
        continue;
      }
      _participants[_participants.indexOf(p)] = p.copyWith(badges: validBadges);
    }

    // sort by:
    // submit time is earliest
    // has the most of badge
    // latest completed badge is earliest
    sortParticipants(sorter: const Sorter(sortType: SortType.submittedTime, orderType: OrderType.asc), needToNotify: false);
    sortParticipants(sorter: const Sorter(sortType: SortType.numBadges, orderType: OrderType.desc), needToNotify: false);
    sortParticipants(sorter: const Sorter(sortType: SortType.completedTime, orderType: OrderType.desc), needToNotify: false);

    if(numberParticipant != null) {
      if(_participants.length > numberParticipant) {
        _participants = _participants.take(numberParticipant).toList();
      }
    }
    notifyListeners();
  }

}

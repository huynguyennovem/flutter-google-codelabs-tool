import 'dart:convert';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_codelabs_tool/entity/api_error.dart';
import 'package:flutter_google_codelabs_tool/entity/badge.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:intl/intl.dart';

class LocalData {

  Future<Either<ApiError, List<Participant>>> getFakeResult() async {
    final rawListData = jsonDecode(DumpData.participants) as List;
    var participantList = rawListData.map((e) => Participant.fromJson(e)).toList();
    // get Badge info for each participant
    for (var p in participantList) {
      final randomData = DumpData().badges..shuffle();
      final get3RandomBadges = randomData.take(Random().nextInt(5)).toList();
      participantList[participantList.indexOf(p)] = p.copyWith(badges: get3RandomBadges);
    }
    return Right(participantList);
  }

  Future<String> getGuideline() async {
    return rootBundle.loadString('assets/GUIDELINE.md');
  }

}

class DumpData {
  static const participants = '[{"Timestamp":"2022-11-12T16:32:35.035Z","Your email":"huynguyennovem@gmail.com","Joined codelab":"Flutter","How to get a certificate":"Get cert on 10/12, Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939"},{"Timestamp":"2022-11-12T16:40:59.071Z","Your email":"huynqnovem@gmail.com","Joined codelab":"Flutter","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/e27d770a-3cfb-485f-998d-d4c518dbddca"},{"Timestamp":"2022-11-13T05:40:59.000Z","Your email":"dsfdsfdsfdsfdfdsf@gmail.com","Joined codelab":"Cloud","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939"},{"Timestamp":"2022-11-13T01:10:11.000Z","Your email":"cxvcmxvmm232cxvm@gmail.com","Joined codelab":"AI","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/e27d770a-3cfb-485f-998d-d4c518dbddca"},{"Timestamp":"2022-11-15T19:40:59.000Z","Your email":"dsoodododoodd@gmail.com","Joined codelab":"AI","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939"},{"Timestamp":"2022-11-17T13:20:12.000Z","Your email":"lllldddddddllldldld@gmail.com","Joined codelab":"Cloud","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939"},{"Timestamp":"2022-11-10T15:30:00.000Z","Your email":"dfd12222ddddzzzz@gmail.com","Joined codelab":"Flutter","How to get a certificate":"Via email","Link public profile":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939"}]';

  final badges = List<Badge>.from([
    Badge('Nguyen Quang Huy', 'Flutter Essential', DateFormat("MMM d yyyy").parse('Nov 3 2022')),
    Badge('Nguyen Quang Huy', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 5 2022')),
    Badge('Nguyen Quang Huy', 'How Google Does Machine Learning', DateFormat("MMM d yyyy").parse('Nov 5 2022')),
    Badge('Nguyen Quang Huy', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 5 2022')),

    Badge('Nguyen Hai Truong', 'Language, Speech, Text, & Translation with Google Cloud APIs', DateFormat("MMM d yyyy").parse('Nov 4 2022')),
    Badge('Nguyen Hai Truong', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 4 2022')),
    Badge('Nguyen Hai Truong', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 8 2022')),

    Badge('Dang Duc Huy', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 7 2022')),
    Badge('Dang Duc Huy', 'Flutter Essential', DateFormat("MMM d yyyy").parse('Nov 8 2022')),
    Badge('Dang Duc Huy', 'Language, Speech, Text, & Translation with Google Cloud APIs', DateFormat("MMM d yyyy").parse('Nov 10 2022')),

    Badge('Nguyen Thanh Dat', 'Flutter Essential', DateFormat("MMM d yyyy").parse('Nov 3 2022')),
    Badge('Nguyen Thanh Dat', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 4 2022')),
    Badge('Nguyen Thanh Dat', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 5 2022')),
    Badge('Nguyen Thanh Dat', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 11 2022')),

    Badge('Le Van Dai', 'Flutter Essential', DateFormat("MMM d yyyy").parse('Nov 2 2022')),
    Badge('Le Van Dai', 'How Google Does Machine Learning', DateFormat("MMM d yyyy").parse('Nov 13 2022')),
    Badge('Le Van Dai', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 3 2022')),
  ]);

}

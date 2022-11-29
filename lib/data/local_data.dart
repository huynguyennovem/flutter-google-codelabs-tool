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
      final get3RandomBadges = randomData.take(Random().nextInt(5)).toSet().toList(); // toSet() to get unique badge (not actually the best solution)
      participantList[participantList.indexOf(p)] = p.copyWith(badges: get3RandomBadges);
    }
    return Right(participantList);
  }

  Future<String> getGuideline() async {
    return rootBundle.loadString('assets/GUIDELINE.md');
  }

}

class DumpData {
  static const participants = '[{"Timestamp":"2022-11-18T20:32:35.035Z","Địa chỉ email đăng ký Online Codelab Challenge":"huynguyennovem@gmail.com","Chủ đề Codelab tham gia":"Flutter","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-19T16:40:59.071Z","Địa chỉ email đăng ký Online Codelab Challenge":"huynqnovem@gmail.com","Chủ đề Codelab tham gia":"Flutter","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/e27d770a-3cfb-485f-998d-d4c518dbddca","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-13T05:40:59.000Z","Địa chỉ email đăng ký Online Codelab Challenge":"dsfdsfdsfdsfdfdsf@gmail.com","Chủ đề Codelab tham gia":"Cloud","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-13T01:10:11.000Z","Địa chỉ email đăng ký Online Codelab Challenge":"cxvcmxvmm232cxvm@gmail.com","Chủ đề Codelab tham gia":"AI","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/e27d770a-3cfb-485f-998d-d4c518dbddca","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-18T23:40:59.000Z","Địa chỉ email đăng ký Online Codelab Challenge":"dsoodododoodd@gmail.com","Chủ đề Codelab tham gia":"AI","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-19T13:20:12.000Z","Địa chỉ email đăng ký Online Codelab Challenge":"lllldddddddllldldld@gmail.com","Chủ đề Codelab tham gia":"Cloud","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939","Hình thức nhận Giấy chứng nhận":"Via email"},{"Timestamp":"2022-11-20T15:30:00.000Z","Địa chỉ email đăng ký Online Codelab Challenge":"dfd12222ddddzzzz@gmail.com","Chủ đề Codelab tham gia":"Flutter","Link public Profile Cloud Skill Boots":"https://www.cloudskillsboost.google/public_profiles/48f6fc57-ef42-47e1-90cb-7c6e59569939","Hình thức nhận Giấy chứng nhận":"Via email"}]';

  final badges = List<Badge>.from([
    Badge('Nguyen Quang Huy', 'Flutter Essentials', DateFormat("MMM d yyyy").parse('Nov 14 2022')),
    Badge('Nguyen Quang Huy', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 15 2022')),
    Badge('Nguyen Quang Huy', 'How Google Does Machine Learning', DateFormat("MMM d yyyy").parse('Nov 20 2022')),
    Badge('Nguyen Quang Huy', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 15 2022')),

    Badge('Nguyen Hai Truong', 'Language, Speech, Text, & Translation with Google Cloud APIs', DateFormat("MMM d yyyy").parse('Nov 7 2022')),
    Badge('Nguyen Hai Truong', 'How Google Does Machine Learning', DateFormat("MMM d yyyy").parse('Nov 11 2022')),
    Badge('Nguyen Hai Truong', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 7 2022')),
    Badge('Nguyen Hai Truong', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 14 2022')),
    Badge('Nguyen Hai Truong', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 18 2022')),

    Badge('Dang Duc Huy', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 17 2022')),
    Badge('Dang Duc Huy', 'Flutter Essentials', DateFormat("MMM d yyyy").parse('Nov 18 2022')),
    Badge('Dang Duc Huy', 'Language, Speech, Text, & Translation with Google Cloud APIs', DateFormat("MMM d yyyy").parse('Nov 16 2022')),

    Badge('Nguyen Thanh Dat', 'Flutter Essentials', DateFormat("MMM d yyyy").parse('Nov 13 2022')),
    Badge('Nguyen Thanh Dat', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 14 2022')),
    Badge('Nguyen Thanh Dat', 'Flutter Development', DateFormat("MMM d yyyy").parse('Nov 24 2022')),
    Badge('Nguyen Thanh Dat', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 11 2022')),

    Badge('Le Van Dai', 'Flutter Essentials', DateFormat("MMM d yyyy").parse('Sep 17 2022')),
    Badge('Le Van Dai', 'How Google Does Machine Learning', DateFormat("MMM d yyyy").parse('Oct 22 2022')),
    Badge('Le Van Dai', 'Invalid lab', DateFormat("MMM d yyyy").parse('Nov 13 2022')),
  ]);

}

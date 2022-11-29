import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_google_codelabs_tool/entity/participant.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../entity/api_error.dart';
import '../entity/badge.dart';
import '../util/util.dart';

class ApiService{

  Future<Either<ApiError, List<Badge>>> getAllBadges(String profileUrl) async {
    final response = await http.get(Uri.parse(profileUrl));
    if (response.statusCode == 200) {
      final parsedString = parse(response.body);
      try {
        final profileName = parsedString.getElementsByClassName('ql-headline-1');
        final owner = profileName.first.text.trim();

        final profileBadges = parsedString.getElementsByClassName('profile-badge');
        final badges = profileBadges.map((e) {
          final name = e.getElementsByClassName('ql-subhead-1 l-mts');
          final time = e.getElementsByClassName('ql-body-2 l-mbs');
          final nameValue = name.first.text.trim();
          final timeValueRaw = time.first.text.trim();  // eg: Earned Nov 3, 2022 EDT
          final timeValue = timeValueRaw.substring(7, timeValueRaw.length - 4).replaceAll(',', '');
          final timeValueTrim = Util.cleanupWhitespace(timeValue);
          final timeValueFormatted = DateFormat("MMM d yyyy").parse(timeValueTrim);
          final badge = Badge(owner, nameValue, timeValueFormatted);
          return badge;
        }).toList();
        return Right(badges);
      } catch (e) {
        // sometime, participant may not submit a proper profile url, the crash will occur
        return const Left(ApiError.empty());
      }
    }
    return const Left(ApiError.empty());
  }

  Future<Either<ApiError, List<Participant>>> getFinalResult(String appScriptUrl) async {
    final response = await http.get(Uri.parse(appScriptUrl));
    if (response.statusCode == 200) {
      final rawListData = jsonDecode(response.body) as List;
      var participantList = rawListData.map((e) => Participant.fromJson(e)).toList();

      // get Badge info for each participant
      for (var p in participantList) {
        final rs = await getAllBadges(p.publicProfile);
        rs.fold((l) {}, (badges) {
          participantList[participantList.indexOf(p)] = p.copyWith(badges: badges);
        });
      }
      return Right(participantList);
    }
    return const Left(ApiError.empty());
  }

}

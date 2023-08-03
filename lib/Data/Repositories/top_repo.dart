import 'dart:convert';

import 'package:http/http.dart' as http;
import '../Models/tab_bars/top_scores/top_scores/top_scores.dart';

class TopScorersRepo {
  Future<TopScores?> getTopScorers(int leagueId) async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Topscorers&leagueId=$leagueId&207&APIkey=e0a1aa20543e8be54adb246f127ae6b89af0bb6c96b83ea255ee5b29489ce114"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        TopScores data = TopScores.fromJson(deCodedResponse);

        return data;
      } else {
        return null;
      }
    } catch (error) {
      print("Error : $error");
    }
  }
}

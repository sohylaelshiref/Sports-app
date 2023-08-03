import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/players/players.dart';

class SportsAppRepo {
  Future<Players?> getPlayerdetail(int teamId) async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Players&APIkey=e0a1aa20543e8be54adb246f127ae6b89af0bb6c96b83ea255ee5b29489ce114&&teamId=$teamId"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        Players data = Players.fromJson(deCodedResponse);

        return data;
      } else {
        return null;
      }
    } catch (error) {
      print("Error : $error");
    }
  }

  Future<Players?> searchByName(String searchText, int teamId) async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Players&playerName=$searchText&APIkey=e0a1aa20543e8be54adb246f127ae6b89af0bb6c96b83ea255ee5b29489ce114&&teamId=$teamId"));

      Map<String, dynamic> deCodedResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        Players data = Players.fromJson(deCodedResponse);

        return data;
      } else {
        return null;
      }
    } catch (error) {
      print("Error : $error");
    }
  }
}

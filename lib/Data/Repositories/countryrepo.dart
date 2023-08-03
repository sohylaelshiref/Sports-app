import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../Models/countrymodel.dart';

class Countryrepo {
  Future<CountriesApi?> getcountry() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=62e2370627c73854ecf77d0eef6d91e88b461d60d91bab231a1d42301b62470e"));

      Map<String, dynamic> decodedresponse = json.decode(response.body);

      if (response.statusCode == 200) {
        CountriesApi data = CountriesApi.fromJson(decodedresponse);

        return data;
      } else {
        // ignore: avoid_print
        print("request failed");
        return null;
      }
    } catch (error) {
      // ignore: avoid_print
      print("Error is : $error");
      return null;
    }
  }
}

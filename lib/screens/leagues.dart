// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/tab_bar_screen.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'countries.dart';

// ignore: non_constant_identifier_names
var leg_id;

// ignore: camel_case_types
class leagues extends StatefulWidget {
  const leagues({super.key});

  @override
  _leaguesState createState() => _leaguesState();
}

class _leaguesState extends State<leagues> {
  @override
  void initState() {
    super.initState();
    leaguesFilter(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Leagues'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/footback.png'), // Set a background image
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _leagues.length,
                itemBuilder: (context, index) {
                  final idlegel = _leagues[index];
                  return GestureDetector(
                    onTap: () {
                      print(idlegel['league_name']);
                      leg_id = idlegel['league_name'];
                      print(leg_id);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabBarScreen(
                                leagueId: _leagues[index]["league_key"])),
                      );
                    },
                    child: Card(
                      color: Color.fromARGB(85, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _leagues[index]['league_logo'] != null
                              ? Image.network(
                                  _leagues[index]['league_logo'],
                                  height: 90,
                                )
                              : const Icon(Icons.sports_soccer),
                          SizedBox(height: 1),
                          Text(_leagues[index]['league_name']),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _leagues = [];
  void leaguesFilter(String query) async {
    var response = await http.get(Uri.parse(
        'https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=854f4753f32ff5beb583f3a4198da02cb4df25fffc7e55c628de40a7961e26de'));
    if (response.statusCode == 200) {
      var leagues = json.decode(response.body)['result'];
      var filteredLeagues = leagues
          .where((league) =>
              league['country_name'].toLowerCase() == query.toLowerCase())
          .toList();
      print('Leagues for $query: $filteredLeagues');
      setState(() {
        _leagues = filteredLeagues;
      });
    }
  }
}

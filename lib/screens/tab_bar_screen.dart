import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/tabsbar/tap_scores_screen.dart';
import 'package:flutter_application_3/screens/tabsbar/tab_team_screen.dart';

class TabBarScreen extends StatefulWidget {
  final int leagueId;
  TabBarScreen({super.key, required this.leagueId});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  // bool _showSearchField = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Teams League",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: const Color(0xFF090A0A),
        ),
        body: Column(
          children: [
            const TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Color(0xFF090A0A),
              tabs: [
                Tab(
                  text: "Teams",
                ),
                Tab(
                  text: "Top Scorers",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  TabTeamScreen(leagueId: widget.leagueId),
                  TabScoresScreen(leagueId: widget.leagueId)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

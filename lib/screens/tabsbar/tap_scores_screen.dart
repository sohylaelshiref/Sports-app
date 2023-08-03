// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Cubits/top_scores/cubit/topscores_cubit.dart';

class TabScoresScreen extends StatefulWidget {
  final int leagueId;
  const TabScoresScreen({super.key, required this.leagueId});

  @override
  State<TabScoresScreen> createState() => _TabScoresScreenState();
}

class _TabScoresScreenState extends State<TabScoresScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<TopscoresCubit>().getTop(widget.leagueId) ??
          Center(
            child: Text("Not Found"),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopscoresCubit, TopscoresState>(
      builder: (context, state) {
        if (state is TopscoresInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopscoresSuccess &&
            state.ourResponse.result != null) {
          return ListView.builder(
            itemCount: state.ourResponse.result!.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            ' Player Name : ${state.ourResponse.result![index].playerName ?? ""}'),
                        Text(
                            ' Goals :  ${state.ourResponse.result![index].goals ?? ""}'),
                        Text(
                            ' Penalty_goals :  ${state.ourResponse.result![index].penaltyGoals ?? ""}'),
                      ],
                    ),
                  ));
            },
          );
        } else {
          return Center(
              child: Text(
            "No scores resive",
            style: TextStyle(color: Color(0xFF04764E), fontSize: 30),
          ));
        }
      },
    );
  }
}

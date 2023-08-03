// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Cubits/teams_cubit/cubit/teams_cubit.dart';
import '../players.dart';

class TabTeamScreen extends StatefulWidget {
  final int leagueId;

  const TabTeamScreen({super.key, required this.leagueId});

  @override
  State<TabTeamScreen> createState() => _TabTeamScreenState();
}

class _TabTeamScreenState extends State<TabTeamScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<TeamsCubit>().getTeams(widget.leagueId) ??
          Center(
            child: Text("Error team"),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsCubit, TeamsState>(
      builder: (context, state) {
        if (state is TeamsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TeamsSuccess && state.ourResponse.result != null) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<TeamsCubit>().searchByTeamName(
                              _searchController.text, widget.leagueId);
                        },
                        child: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 3.5,
                      ),
                      itemCount: state.ourResponse.result!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Card(
                              margin: const EdgeInsets.all(10.0),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${state.ourResponse.result![index].teamLogo ?? " "}',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                              'images/person.jpg');
                                        },
                                      ),
                                    ),
                                    Text(
                                        ' ${state.ourResponse.result![index].teamName ?? " "}'),
                                  ],
                                ),
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Team(
                                      teamId: state.ourResponse.result![index]
                                              .teamKey ??
                                          96)),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Text("Team not found"),
          );
        }
      },
    );
  }
}

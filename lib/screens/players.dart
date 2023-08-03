// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/Cubits/cubit/player_detail_cubit.dart';
import '../Shared/players_row.dart';

class Team extends StatefulWidget {
  final int teamId;
  const Team({super.key, required this.teamId});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      context.read<PlayerDetailCubit>().getPlayers(widget.teamId) ??
          Center(
            child: Text("Error player"),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 45, left: 15, right: 15, bottom: 15),
              child: Row(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<PlayerDetailCubit>().searchByPlayerName(
                              searchText: _searchController.text,
                              teamId: widget.teamId);
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
              ]),
            ),
            BlocBuilder<PlayerDetailCubit, PlayerDetailState>(
              builder: (context, state) {
                if (state is PlayerDetailLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PlayerDetailSuccess &&
                    state.ourResponse.result != null) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.ourResponse.result!.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${state.ourResponse.result![index].playerImage ?? " "}',
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) {
                                      return Image.asset('images/person.jpg');
                                    },
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        '       ${state.ourResponse.result![index].playerName ?? "Not Available"}\n',
                                    style: TextStyle(
                                        color: Color(0xFF090A0A),
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '\n       ${state.ourResponse.result![index].playerType ?? "Not Available"}',
                                        style: TextStyle(
                                          color: Color(0xFF72777A),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '   ,  ${state.ourResponse.result![index].playerNumber ?? "Not Available"}',
                                        style: TextStyle(
                                          color: Color(0xFF72777A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${state.ourResponse.result![index].playerImage ?? "https://media.istockphoto.com/id/1393750072/vector/flat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg?s=612x612&w=0&k=20&c=s9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU="}',
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                  'images/person.jpg');
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        PlayersRow(
                                          property: "Name",
                                          value: state.ourResponse
                                                  .result![index].playerName ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Number",
                                          value: state
                                                  .ourResponse
                                                  .result![index]
                                                  .playerNumber ??
                                              " ",
                                        ),
                                        PlayersRow(
                                          property: "Country",
                                          value: state
                                                  .ourResponse
                                                  .result![index]
                                                  .playerCountry ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Position",
                                          value: state.ourResponse
                                                  .result![index].playerType ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Age",
                                          value: state.ourResponse
                                                  .result![index].playerAge ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Yellow Cards Num",
                                          value: state
                                                  .ourResponse
                                                  .result![index]
                                                  .playerYellowCards ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Red Cards Num",
                                          value: state
                                                  .ourResponse
                                                  .result![index]
                                                  .playerRedCards ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Goals",
                                          value: state.ourResponse
                                                  .result![index].playerGoals ??
                                              "Not Available",
                                        ),
                                        PlayersRow(
                                          property: "Assists",
                                          value: state
                                                  .ourResponse
                                                  .result![index]
                                                  .playerAssists ??
                                              "Not Available",
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Close",
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF04764E),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                  actionsPadding: EdgeInsets.all(20),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                );
                              });
                        },
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text("Data player not found"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

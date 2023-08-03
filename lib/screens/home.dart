// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Data/Cubits/Country_cubit/all_countries_cubit.dart';
import 'countries.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Sports')),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GridView.count(
          crossAxisCount: 2,

          childAspectRatio: 0.5,
          mainAxisSpacing: 3, // Adjust the spacing between rows vertically
          crossAxisSpacing:
              3, // Adjust the spacing between columns horizontally

          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: _buildSportWidget(
                    context, '\nFootball', 'images/football.png')),
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: _buildSportWidget(
                    context, '\nBasketball', 'images/basketball.png')),
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: _buildSportWidget(
                    context, '\nCricket', 'images/cricit.png')),
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: _buildSportWidget(
                    context, '\nTennis', 'images/tennis.png')),
          ],
        ),
      ),
    );
  }

  Widget _buildSportWidget(
      BuildContext context, String name, String imagePath) {
    return SizedBox(
      height: 500,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        // color: const Color.fromARGB(138, 37, 216, 118),
        color: Color.fromARGB(255, 255, 255, 255),

        child: InkWell(
          onTap: () {
            if (name != '\nFootball') {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Coming soon'),
                    content: const Text('This sport is not available yet.'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.green), // Set background color
                        ),
                        child: const Text('OK',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              //   var ourresponse = Countryrepo().getcountry();
              context.read<AllCountriesCubit>().getAllCountres();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CountryScreen()),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
              Text(
                name,
                //  style: const TextStyle(fontSize: 24.0,),
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

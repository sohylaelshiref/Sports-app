import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Data/Cubits/Country_cubit/all_countries_cubit.dart';
import 'leagues.dart';

// ignore: prefer_typing_uninitialized_variables
var id;

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  @override
  void initState() {
    getcountry();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Select Country'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/footback.png'), // Set a background image
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<AllCountriesCubit, AllCountriesState>(
          builder: (context, state) {
            if (state is AllCountriesSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: country.length,
                itemBuilder: (BuildContext context, int index) {
                  final count = country[index];
                  return GestureDetector(
                    onTap: () {
                      print(count['country_name']);
                      id = count['country_name'];
                      print(count['country_name']);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const leagues()),
                      );
                    },
                    child: Card(
                      color: const Color.fromARGB(85, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          count['country_logo'] != null
                              ? Image.network(
                                  count['country_logo'],
                                  height: 70,
                                )
                              : const Icon(Icons.flag),
                          Text(count['country_name'],
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }

  List country = [];

  Future<void> getcountry() async {
    final url = Uri.parse(
        "https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=62e2370627c73854ecf77d0eef6d91e88b461d60d91bab231a1d42301b62470e");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      setState(() {
        country.addAll(responsebody['result']);
      });
    } else {
      // Handle the error here
    }
  }
}

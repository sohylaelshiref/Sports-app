// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/opening_srceens/splashscreen.dart';

//import 'package:flutter_application_3/screens/opening_srceens/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Data/Cubits/Country_cubit/all_countries_cubit.dart';
import 'Data/Cubits/cubit/player_detail_cubit.dart';
import 'Data/Cubits/teams_cubit/cubit/teams_cubit.dart';
import 'Data/Cubits/top_scores/cubit/topscores_cubit.dart';
import 'Shared/onbording_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => OnBoardingViewModel(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PlayerDetailCubit(),
        ),
        BlocProvider(
          create: (context) => AllCountriesCubit(),
        ),
        BlocProvider(
          create: (context) => TopscoresCubit(),
        ),
        BlocProvider(
          create: (context) => TeamsCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //  theme: ThemeData(
        //   primarySwatch:Colors.black ,
        //  ),
        home: SplashScreen(),
      ),
    );
  }
}

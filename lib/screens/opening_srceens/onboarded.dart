// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Data/data/pageview.dart';
import '../../Shared/onbording_view_model.dart';

import 'package:google_fonts/google_fonts.dart';

import '../home.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _controller = PageController(initialPage: 0);

  final int _numPages = 3;

  int _currentPage = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _stopTimer() {
    // ignore: unnecessary_null_comparison
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      // _timer = Null a
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double mWidth = MediaQuery.of(context).size.width;
    double mHeight = MediaQuery.of(context).size.height;
    var provider = Provider.of<OnBoardingViewModel>(context);
    return Scaffold(
      backgroundColor: Color(0xFF04764E),
      body: Stack(children: [
        PageView(
            controller: _controller,
            onPageChanged: (value) {
              provider.changeScreenIndex(value);
            },
            children: myData
                .map((item) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            SizedBox(
                              height: 90,
                            ),
                            SizedBox(
                                width: mWidth * 0.8,
                                height: mHeight * 0.3,
                                child: Image.asset(item.imageurl)),
                            SizedBox(
                              height: mHeight * 0.15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: mWidth * 0.6,
                                height: mHeight * 0.2,
                                child: Text(
                                  item.title,
                                  style: GoogleFonts.pacifico(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 239, 241, 238)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Positioned(
                              top: mHeight * 0.9,
                              left: mWidth * 0.2,
                              child: SmoothPageIndicator(
                                controller: _controller,
                                count: 3,
                                effect: ExpandingDotsEffect(
                                    spacing: 5,
                                    expansionFactor: 2,
                                    dotWidth: mWidth * 0.03,
                                    activeDotColor: Colors.black38,
                                    dotColor:
                                        Color.fromARGB(255, 195, 207, 19)),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: mHeight * 0.08),
                      ],
                    ))
                .toList()),
        provider.currentIndex == 2
            ? Positioned(
                top: mHeight * 0.1,
                left: mWidth * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Positioned(
                    top: mHeight * 0.8,
                    left: mWidth * 0.22,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 60,
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 180,
                  ),
                  provider.currentIndex != 0
                      ? Positioned(
                          top: mHeight * 0.05,
                          right: mWidth * 0.01,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SportsScreen()),
                                ModalRoute.withName('/SportsScreen'),
                              );
                            },
                            child: Text("Skip",
                                style: GoogleFonts.pacifico(
                                    fontSize: mHeight * 0.05,
                                    color: Color.fromARGB(255, 195, 207, 19))),
                          ),
                        )
                      : Container(),
                ]),
              )
            : SizedBox(),
      ]),
    );
  }
}

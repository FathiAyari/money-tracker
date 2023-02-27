import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymanager/ui/shared/dimensions/dimensions.dart';
import 'package:moneymanager/ui/views/home_view.dart';

import '../shared/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var timer = Timer(Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: splashColor,
          body: Container(
            height: Constants.screenHeight,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.1),
                  child: Text(
                    'Money Manager',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
                Lottie.asset(
                  "assets/lotties/wallet.json",
                  width: Constants.screenWidth,
                ),
                Text(
                  'A place for all of your expenses.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    "assets/lotties/loading.json",
                    height: Constants.screenWidth * 0.2,
                  ),
                )
              ],
            ),
          )),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learnflutternew/Courses.dart';
import 'package:learnflutternew/Login.dart';
import 'package:learnflutternew/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenLoader extends StatefulWidget {
  const HomeScreenLoader({Key? key}) : super(key: key);

  @override
  State<HomeScreenLoader> createState() => _HomeScreenLoaderState();
}

class _HomeScreenLoaderState extends State<HomeScreenLoader> {
  late bool checkFirstTime;

  void loadnewLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      checkFirstTime = prefs.getBool('checkfirstTime') ?? true;
    });
  }

  @override
  void initState() {
    loadnewLaunch();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        print(checkFirstTime);
        if (checkFirstTime) {
          Navigator.of(context).pushNamed('$Login');
        } else
          Navigator.of(context).pushNamed('$Courses',arguments: {'category': "all"});
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image(
                image: AssetImage('assets/logotext.png'),
                width: MediaQuery.of(context).size.width * 0.5),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.04,
                widthFactor: 1,
                child: Indicator()),
          )
        ],
      ),
    );
  }
}

class Indicator extends StatefulWidget {
  const Indicator({Key? key}) : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isDoneLoad = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.black,
              value: animation.value,
            ),
          ),
          Expanded(
              flex: 5,
              child: FractionallySizedBox(
                heightFactor: 0.5,
                child: FittedBox(
                    alignment: Alignment.center, child: Text('Version 1.0')),
              ))
        ]),
      ),
    );
  }
}

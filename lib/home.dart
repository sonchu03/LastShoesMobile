import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnflutternew/Chooseshoecategory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
              heightFactor: 0.4,
              widthFactor: 1,
              alignment: Alignment.bottomCenter,
              child: const GetStartedBackground()),
        ),
        FractionallySizedBox(
            heightFactor: 0.4, widthFactor: 1, child: const GetStartedHeader()),
        Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
              heightFactor: 0.2,
              widthFactor: 1,
              child: ButtonEndClass(size: size)),
        ),
       
      ])),
    );
  }
}

class ButtonEndClass extends StatefulWidget {
  const ButtonEndClass({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ButtonEndClass> createState() => _ButtonEndClassState();
}

class _ButtonEndClassState extends State<ButtonEndClass> {
  @override
  Widget build(BuildContext context) {
    var checkFirstTime;

    void loadnewLaunch() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        checkFirstTime = prefs.setBool('checkfirstTime', false);
      });
    }

    return Align(
      alignment: Alignment(0, 0.9),
      child: ElevatedButton(
        child: Row(
          children: [
            Spacer(),
            Text(
              'Let Go',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/logo.png',
              color: Colors.white,
            ),
            Spacer(),
          ],
        ),
        onPressed: () {
          loadnewLaunch();
          Navigator.of(context).pushNamed('$Choosesshoecategory');
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
            elevation: MaterialStateProperty.all(0),
            fixedSize: MaterialStateProperty.all(
                Size(widget.size.width * 0.8, widget.size.height * 0.06))),
      ),
    );
  }
}

class GetStartedBackground extends StatelessWidget {
  const GetStartedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset('assets/jdi.png'));
  }
}

class GetStartedHeader extends StatelessWidget {
  const GetStartedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          flex: 2,
          child: Image.asset(
            'assets/logo.png',
            alignment: Alignment(0, -0.5),
          )),
      Expanded(
          flex: 3,
          child: Column(
            children: [
              Text(
                'Hi new guy ,Welcome',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'to NikeShop',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                'Wanna to buy something shoes come to me',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              )
            ],
          )),
    ]);
  }
}

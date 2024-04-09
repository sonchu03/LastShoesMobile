import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learnflutternew/Login.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(flex: 1, child: headingIF()),
          Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        flex: 2,
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.75,
                          child: CircleAvatar(
                            child: Icon(Icons.person_outline),
                          ),
                        )),
                    Expanded(
                        child: FractionallySizedBox(
                      heightFactor: 0.5,
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                          alignment: Alignment.center, child: Text('User')),
                    ))
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: ButtonatInfo(
                labelofB: 'Purchased Shoes',
              )),
          Expanded(
              flex: 1,
              child: ButtonatInfo(
                labelofB: 'Infomation',
              )),
          Expanded(flex: 1, child: ButtonatInfo(labelofB: 'Order Status')),
          Expanded(flex: 1, child: InkWell(onTap: () {
            Navigator.of(context).pushNamed('$Login');
          },child: ButtonatInfo(labelofB: 'Log out'))),
          Spacer(),
        ],
      )),
    );
  }
}

class headingIF extends StatelessWidget {
  const headingIF({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), //or 15.0
              child: Container(
                height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width * 0.12,
                color: Colors.grey[200],
                child: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 8,
          fit: FlexFit.tight,
          child: Container(
              height: MediaQuery.of(context).size.width * 0.12,
              child: Image(image: AssetImage('assets/logo.png'))),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

class ButtonatInfo extends StatelessWidget {
  const ButtonatInfo({Key? key, required this.labelofB}) : super(key: key);

  final String labelofB;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.75,
      widthFactor: 0.9,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.0),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 9,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: FittedBox(
                        alignment: Alignment.centerLeft, child: Text(labelofB)),
                  )),
              Expanded(child: FittedBox(child: Icon(Icons.navigate_next_sharp)))
            ],
          ),
        ),
      ),
    );
  }
}

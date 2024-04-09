import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learnflutternew/Courses.dart';
import 'package:learnflutternew/CoursesDetails.dart';
import 'package:learnflutternew/data/shoes_storage.dart';
import 'package:learnflutternew/model/shoes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ShoesStotageSl = AssetShoesStorage();

class ShoesLove extends StatefulWidget {
  const ShoesLove({Key? key}) : super(key: key);

  @override
  State<ShoesLove> createState() => _ShoesLoveState();
}

List<String> listlove = [];

class _ShoesLoveState extends State<ShoesLove> {
  void loadLoveShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listlove = prefs.getStringList('item') ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadLoveShoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: headingSL()),
          Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder(
                    future: ShoesStotageSl.load(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if(snapshot.hasError){
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }else if(snapshot.hasData) {
                        var item = snapshot.data as List<ShoesModel>;
                        if(listlove.length == 0){
                          return  Column(
                        children: [
                          Expanded(flex: 6,child: FractionallySizedBox(widthFactor: 0.75,heightFactor: 0.75,child: Image(fit: BoxFit.cover,image: AssetImage('assets/empty.png')))),
                          Expanded(
                            flex: 4,
                            child: FractionallySizedBox(
                            heightFactor: 0.15,
                            widthFactor: 0.75,
                            alignment: Alignment.topCenter,
                            child: FittedBox(child: Text('My Love Is Empty :('))))
                        ],
                      );
                        }
                        return GridView.builder(
                            itemCount: listlove.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 5),
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('$CoursesDetails', arguments: {
                                    'id': int.parse(listlove[index])
                                  });
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.network(
                                                  item[int.parse(
                                                          listlove[index])]
                                                      .image
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                                Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05,
                                                    ))
                                              ],
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child:
                                                          FractionallySizedBox(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        heightFactor: 1,
                                                        child: FittedBox(
                                                          child: Text(
                                                              item[index]
                                                                  .name
                                                                  .toString()),
                                                        ),
                                                      )),
                                                  Expanded(
                                                      flex: 1,
                                                      child: FittedBox(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text('\$' +
                                                            (item[index].price! /
                                                                    100)
                                                                .toString()),
                                                      )),
                                                  Spacer()
                                                ],
                                              ),
                                            ))
                                      ]),
                                ),
                              );
                            }));
                      }

                      return Container();
                    }),
              ))
        ],
      )),
    );
  }
}

class headingSL extends StatelessWidget {
  const headingSL({
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
                child: Icon(
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

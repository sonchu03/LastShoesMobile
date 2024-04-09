

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/shoes_storage.dart';
import 'model/shoes_model.dart';

final shoesStorage = AssetShoesStorage();
const SizeofShoes = ['8', '9', '10', '11', '12', '13', '14'];

class CoursesDetails extends StatefulWidget {
  const CoursesDetails({Key? key}) : super(key: key);

  @override
  _CoursesDetailsState createState() => _CoursesDetailsState();
}

class _CoursesDetailsState extends State<CoursesDetails> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    Icon icongender;
    data = data.isNotEmpty
        ? {'id': 3}
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data['id']);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: shoesStorage.load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Hiển thị tiêu đề chờ nếu dữ liệu đang được tải
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi xảy ra
              } else if (snapshot.hasData) {
                var item = snapshot.data as List<ShoesModel>;
                if (item[data['id']].gender![0].toString() == 'men') {
                  icongender = Icon(Icons.man);
                } else if (item[data['id']].gender![0].toString() == 'women') {
                  icongender = Icon(Icons.woman);
                } else {
                  icongender = Icon(Icons.child_care_sharp);
                }

                return Column(children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: headingPD(
                        id: data['id'].toString(),
                      )),
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ImagePD(urlImg: item[data['id']].image
                            .toString()),
                      )),
                  Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: FractionallySizedBox(
                                          alignment: Alignment.bottomLeft,
                                          heightFactor: 0.5,
                                          child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                item[data['id']].name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              )),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(item[data['id']]
                                                  .category![0]
                                                  .toString())),
                                        )),
                                    Spacer()
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: FractionallySizedBox(
                                          alignment: Alignment.topLeft,
                                          heightFactor: 0.75,
                                          child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Gender',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              )),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: FractionallySizedBox(
                                          heightFactor: 0.75,
                                          alignment: Alignment.centerLeft,
                                          child: FittedBox(
                                            alignment: Alignment.centerLeft,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.transparent,
                                                border: Border.all(
                                                    color: Color(0xFFA1A4B2)),
                                              ),
                                              child: Center(child: icongender),
                                            ),
                                          ),
                                        )),
                                    Spacer(),
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: FractionallySizedBox(
                                          alignment: Alignment.topLeft,
                                          heightFactor: 0.75,
                                          child: FittedBox(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Size',
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold),
                                              )),
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: List.generate(7, (index) {
                                          return Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.transparent,
                                                  border: Border.all(
                                                      color: Color(0xFFA1A4B2)),
                                                ),
                                                child: Center(
                                                  child: FittedBox(
                                                      child:
                                                      Text(SizeofShoes[index])),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ))
                          ],
                        ),
                      )),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: BottomPd(
                          price: int.parse(item[data['id']].price.toString()),
                          id: data['id'].toString()),
                    ),
                  ),
                ]);
              }
              else{
                return Center(
                  child: Text('No data available'),
                );
              }
            }),
      ),
    );
  }
}

class BottomPd extends StatefulWidget {
  const BottomPd({Key? key, required this.price, required this.id})
      : super(key: key);

  final int price;
  final String id;

  @override
  State<BottomPd> createState() => _BottomPdState();
}

List<String> listcard = [];

class _BottomPdState extends State<BottomPd> {
  void saveCardShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listcard.add(widget.id);
      prefs.setStringList('itemcard', listcard);

      print(listcard);
    });
  }

  void loadCardShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listcard = prefs.getStringList('itemcard') ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadCardShoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: FittedBox(
                      alignment: Alignment.topLeft, child: Text('Price'))),
              Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: FittedBox(
                      alignment: Alignment.bottomLeft,
                      child: Text("\$" + (widget.price / 100).toString())))
            ],
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              saveCardShoes();
            },
            child: Text('Add to Bag',
              style:TextStyle(color: Colors.black) ,),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                side: BorderSide(color: Colors.black),
                ),
              ),
              elevation: MaterialStateProperty.all(0),
              // Thêm một hiệu ứng màu khi nút được nhấn
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey.withOpacity(0.5); // Màu xám nhạt khi nút được nhấn
                  }
                  return Colors.transparent; // Trả về màu trong suốt khi nút không được nhấn
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImagePD extends StatelessWidget {
  const ImagePD({Key? key, required this.urlImg}) : super(key: key);

  final String urlImg;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/logotext.png'),
              color: Colors.grey[500],
              fit: BoxFit.cover,
            ),
          ),
          Image(
              fit: BoxFit.cover,
              image: NetworkImage(urlImg),
              width: MediaQuery.of(context).size.width),
        ],
      ),
    );
  }
}

class headingPD extends StatefulWidget {
  const headingPD({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<headingPD> createState() => _headingPDState();
}

bool islove = false;
Icon iconlove = Icon(
  Icons.favorite_border,
  color: Colors.black,
);
List<String> listlove = [];

class _headingPDState extends State<headingPD> {
  void loadLoveShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listlove = prefs.getStringList('item') ?? [];
      for (int i = 0; i < listlove.length; i++) {
        print(widget.id + listlove[i]);
        if (widget.id == listlove[i]) {
          print('co thich');
          islove = true;
          iconlove = Icon(
            Icons.favorite,
            color: Colors.black,
          );
          break;
        } else {
          print('ko thich');
          islove = false;
          iconlove = Icon(
            Icons.favorite_border,
            color: Colors.black,
          );
        }
      }
    });
  }

  @override
  void initState() {
    loadLoveShoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void saveLoveShoes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        listlove.add(widget.id);
        prefs.setStringList('item', listlove);
        print(listlove);
      });
    }

    void removeLoveShoes() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        listlove.remove(widget.id);
        prefs.setStringList('item', listlove);
        print(listlove);
      });
    }

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
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              setState(() {
                if (islove) {
                  iconlove = Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  );
                  removeLoveShoes();

                  islove = false;

                  // );
                } else {
                  iconlove = Icon(
                    Icons.favorite,
                    color: Colors.black,
                  );
                  saveLoveShoes();

                  islove = true;
                }
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), //or 15.0
              child: Container(
                height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width * 0.12,
                color: Colors.grey[200],
                child: iconlove,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

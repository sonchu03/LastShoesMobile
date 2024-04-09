import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnflutternew/CoursesDetails.dart';
import 'package:learnflutternew/Info.dart';
import 'package:learnflutternew/Login.dart';
import 'package:learnflutternew/data/shoes_storage.dart';
import 'package:learnflutternew/model/shoes_model.dart';
import 'package:learnflutternew/shoes_cart.dart';
import 'package:learnflutternew/shoes_love.dart';

final shoesStorage = AssetShoesStorage();

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);
  @override
  _CoursesState createState() => _CoursesState();
}
   List<ShoesModel> _listshoes = [];
  List<ShoesModel> _listsearch = [];
class _CoursesState extends State<Courses> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? {'category' : 'all'} : ModalRoute.of(context)!.settings.arguments as Map;
    // print(data['category']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Products',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('$ShoesLove');
              },
              icon: Icon(Icons.favorite_border)),
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('$ShoesCart');
              },
              icon: Icon(Icons.add_shopping_cart)),
          IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed('$Info');
              },
              icon: Icon(Icons.perm_identity)),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: FutureBuilder(
          future: shoesStorage.load(),
          builder: (context,snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if(snapshot.hasData){
                var item = snapshot.data as List<ShoesModel>;
                    if(_listshoes.isEmpty){
                          if(data['category'] == 'all'){
                      _listshoes = item;
                      print('Courses' + "all");
                    }else if(data['category']=='Lifestyle'){
                      for(int i = 0;i<item.length;i++){
                        if(item[i].category![0] == 'lifestyle'){
                          print('course cua i' + i.toString());
                          // new ShoesModel(id: item[i].id,category: item[i].category,gender: item[i].gender,image: item[i].image,name: item[i].name,price: item[i].price,size: item[i].size)
                          _listshoes.add(item[i]);
                        }
                      }
 
                    }else if(data['category']=='Air Jordan'){
                        print('Courses' + "airjordan");
                        _listshoes = item;
                        _listshoes = _listshoes.where((ShoesModel) {
                                  var postitle = ShoesModel.name!.toLowerCase();
                                  return postitle.contains("air jordan");
                                }).toList();

                    }else if(data['category']=='Basketball'){
                        print('Courses' + "baskerball");
                         for(int i = 0;i<item.length;i++){
                        if(item[i].category![0] == 'basketball'){
                          print('course cua i' + i.toString());
                          // new ShoesModel(id: item[i].id,category: item[i].category,gender: item[i].gender,image: item[i].image,name: item[i].name,price: item[i].price,size: item[i].size)
                          _listshoes.add(item[i]);
                        }
                      }
                    }else if(data['category']=='Running'){
                        print('Courses' + "running");
                         for(int i = 0;i<item.length;i++){
                        if(item[i].category![0] == 'running'){
                          print('course cua i' + i.toString());
                          // new ShoesModel(id: item[i].id,category: item[i].category,gender: item[i].gender,image: item[i].image,name: item[i].name,price: item[i].price,size: item[i].size)
                          _listshoes.add(item[i]);
                        }
                      }
                    }else {
                          _listshoes = item;
                      print('Courses' + "all");
                        }
                         _listsearch = _listshoes;
                     }
            }
            else{
              // Xử lý trường hợp dữ liệu là null
              return Center(
                child: Text('No data available'),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 3,
                          child: TextField(
                            onChanged: (text) {
                              text = text.toLowerCase();
                              
                              setState(() {
                                _listsearch = _listshoes.where((ShoesModel) {
                                  var postitle = ShoesModel.name!.toLowerCase();
                                  return postitle.contains(text);
                                }).toList();
                                print('First text field: $text');
                                print(_listsearch.length.toString());
                              });
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                label: Text('Search Product'),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                suffixIcon: Icon(Icons.search)),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'We found 13 product avilable for you',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                    flex: 10,
                    child: ListView.builder(
                             
                              itemCount: _listsearch.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '$CoursesDetails',
                                        arguments: {'id': index});
                                    print('length when change' + _listshoes.length.toString() );

                                  },
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    elevation: 5,
                                    color: Colors.grey[200],
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Image(
                                                    image: AssetImage(
                                                        'assets/logotext.png'),
                                                    color: Colors.grey[500],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Image.network(
                                                    _listsearch[index].image.toString(),
                                                    fit: BoxFit.cover,
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 5),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 8,
                                                      fit: FlexFit.tight,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: [
                                                          Flexible(
                                                              flex: 2,
                                                              child: FittedBox(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Text(_listsearch[
                                                                          index]
                                                                      .name
                                                                      .toString()))),
                                                          Flexible(
                                                              flex: 1,
                                                              child: FittedBox(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: Text(
                                                                    _listsearch[index]
                                                                        .category![0],
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300),
                                                                  ))),
                                                          Spacer(
                                                            flex: 1,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Flexible(
                                                        flex: 2,
                                                        fit: FlexFit.tight,
                                                        child: FittedBox(
                                                            alignment:
                                                                Alignment.topRight,
                                                            child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.black,
                                                                child: Icon(
                                                                  Icons
                                                                      .shopping_bag_outlined,
                                                                  color:
                                                                      Colors.white,
                                                                ))))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          

                         )
              ],
            );
          }
        ),
      ),
    );
  }
  
 void change(String text){
    text = text.toLowerCase();
    setState(() {
      _listsearch = _listshoes.where((ShoesModel) {
         var postitle = ShoesModel.name!.toLowerCase();
         return postitle.contains(text);
      }).toList();
    });
 }
}

Widget CustomCardCoures(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CoursesDetails()));
    },
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 5,
      color: Colors.grey[200],
      child: Container(
        color: Color(0xFFB7B7B7),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 3,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                    'https://image.goat.com/375/attachments/product_template_pictures/images/012/750/761/original/351623_00.png.png',
                    fit: BoxFit.cover),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                                flex: 2,
                                child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Nike Air Max 200'))),
                            Flexible(
                                flex: 1,
                                child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Running',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ))),
                            Spacer(
                              flex: 1,
                            )
                          ],
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: FittedBox(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.white,
                                  ))))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}



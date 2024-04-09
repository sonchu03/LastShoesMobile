import 'package:flutter/material.dart';
import 'package:learnflutternew/Courses.dart';
import 'package:learnflutternew/model/category_model.dart';

class Choosesshoecategory extends StatelessWidget {
  const Choosesshoecategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryModed> categoryModel = [
      CategoryModed(
          title: 'Air Jordan',
          thumbnail:
              'https://image.goat.com/375/attachments/product_template_pictures/images/008/870/353/original/235806_00.png.png',
          color: '0xFFB7B7B7',
          titleColor: '0xFF3A3A3A'),
      CategoryModed(
          title: 'Basketball',
          thumbnail:
              'https://image.goat.com/375/attachments/product_template_pictures/images/020/840/270/original/491192_00.png.png',
          color: '0xFFB56161',
          titleColor: '0xFFE9E9E9'),
      CategoryModed(
          title: 'Lifestyle',
          thumbnail:
              'https://image.goat.com/375/attachments/product_template_pictures/images/019/367/662/original/484799_00.png.png',
          color: '0xFF262626B',
          titleColor: '0xFFE9E9E9'),
      CategoryModed(
          title: 'Running',
          thumbnail:
              'https://image.goat.com/375/attachments/product_template_pictures/images/021/321/832/original/503571_00.png.png',
          color: '0xFFCCCC00',
          titleColor: '0xFF353535'),
    ];
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Flexible(flex: 1, fit: FlexFit.tight, child: _Headear()),
          Flexible(
              flex: 3,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
                itemCount: categoryModel.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('$Courses',arguments: {'category': categoryModel[index].title});
                    },
                    child: Card(
                      color: Color(int.parse(categoryModel[index].color)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Image.network(
                              categoryModel[index].thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                categoryModel[index].title,
                                style: TextStyle(
                                  color: Color(int.parse(
                                      categoryModel[index].titleColor)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ))
        ],
      )),
    );
  }
}

class _Headear extends StatelessWidget {
  const _Headear({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(
            flex: 3,
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: 'What kind of Shoes\n',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: 'do you like?',
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ]),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose the type of shoes you love:',
                  style: TextStyle(fontSize: 18),
                ),
              )),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}

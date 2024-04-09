import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learnflutternew/Chooseshoecategory.dart';
import 'package:learnflutternew/Signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;
  String labelInput = 'Email';
  Icon icontop = Icon(Icons.email_outlined);

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static Future<User?> loginUsingEmailPassword({required String email,required String password,required BuildContext context}) async{
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user;
        try{
          UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
          user = userCredential.user;
        }on FirebaseAuthException catch(e){
          if(e.code =="user-not-found"){
                print('No user not found');
          }
        }
        return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
     TextEditingController _passController = TextEditingController();
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            print('co snap shot');
            return SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: FractionallySizedBox(
                          heightFactor: 0.5,
                          widthFactor: 0.5,
                          child: Image(
                            image: AssetImage('assets/logotext.png'),
                            fit: BoxFit.cover,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerRight,
                          heightFactor: 0.85,
                          widthFactor: 0.85,
                          child: Image(
                            image: AssetImage('assets/shoeslogin.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: FittedBox(
                              child: Text(
                                'Welcome back!',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                            Expanded(
                                child: FractionallySizedBox(
                              heightFactor: 0.5,
                              alignment: Alignment.center,
                              child: FittedBox(
                                child: Text(
                                  'Enter your email and password',
                                  style: TextStyle(),
                                ),
                              ),
                            )),
                            Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                          child: InputForm(
                        icontop: icontop,
                        labelInput: labelInput,
                        hinttext: false,
                        textEditingController: _emailController,
                      )),
                      Expanded(
                          child: InputForm(
                        icontop: Icon(Icons.lock_outline_sharp),
                        labelInput: 'Password',
                        hinttext: true,
                        textEditingController: _passController,
                      )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: FractionallySizedBox(
                                alignment: Alignment.topCenter,
                                heightFactor: 0.5,
                                child: FittedBox(
                                  alignment: Alignment.topCenter,
                                  child: Checkbox(
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                      value: isRememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isRememberMe = value!;
                                        });
                                      }),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: FractionallySizedBox(
                                  heightFactor: 0.5,
                                  alignment: Alignment.topCenter,
                                  child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Remember')),
                                )),
                            Spacer(
                              flex: 3,
                            ),
                            Expanded(
                              flex: 3,
                              child: FractionallySizedBox(
                                heightFactor: 0.5,
                                alignment: Alignment.topCenter,
                                child: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Forget password!',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: FractionallySizedBox(
                        heightFactor: 0.8,
                        widthFactor: 0.9,
                        child: ElevatedButton(
                          onPressed: () async {
                            User? user = await loginUsingEmailPassword(
                              email: _emailController.text,
                              password: _passController.text,
                              context: context,
                            );
                            if (user != null) {
                              // Đăng nhập thành công, chuyển hướng người dùng đến trang mới, ví dụ 'HomePage'
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Choosesshoecategory()),
                              );
                            } else {
                              // Xử lý trường hợp đăng nhập không thành công, ví dụ hiển thị thông báo lỗi
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Đăng nhập không thành công. Vui lòng thử lại.'),
                              ));
                            }
                          },
                          child: FractionallySizedBox(
                            heightFactor: 0.3,
                            widthFactor: 0.5,
                            child: FittedBox(child: Text('Login',
                              style: TextStyle(color: Colors.black),)),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                            elevation: MaterialStateProperty.all(0),
                            // Thêm một hiệu ứng màu khi nút được nhấn
                            overlayColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey.withOpacity(
                                      0.5); // Màu xám nhạt khi nút được nhấn
                                }
                                return Colors
                                    .transparent; // Trả về màu trong suốt khi nút không được nhấn
                              },
                            ),
                          ),
                        ),

                          )),
                      Expanded(
                          child: FractionallySizedBox(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        widthFactor: 0.6,
                        child: FittedBox(
                          child: RichText(
                            text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: 'Signup',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context)
                                              .pushNamed('$SignUp');
                                        }),
                                ]),
                          ),
                        ),
                      )),
                      Spacer(),
                    ],
                  ))
            ]),
          );
          }
          print('ko co nap shot');
          return const Center(
            child: CircularProgressIndicator(),
          );
          
        }
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm(
      {Key? key,
      required this.icontop,
      required this.labelInput,
      required this.hinttext,
      required this.textEditingController})
      : super(key: key);

  final Icon icontop;
  final String labelInput;
  final bool hinttext;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.75,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.0),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              //or 15.0
              child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      topLeft: Radius.circular(18),
                    ),
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 0.5,
                    child: FittedBox(child: icontop),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: FractionallySizedBox(
                  heightFactor: 1,
                  child: TextField(
                    controller: textEditingController,
                    obscureText: hinttext,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        height: 2.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                        label: Text(labelInput),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ))),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

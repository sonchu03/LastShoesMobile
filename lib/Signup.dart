import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:learnflutternew/Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _signUp() async {
    // Kiểm tra nếu email hoặc mật khẩu rỗng
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), // Loại bỏ khoảng trắng thừa
        password: _passwordController.text,
      );
      // Xử lý đăng ký thành công ở đây
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } catch (e) {
      // Xử lý lỗi đăng ký ở đây
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                  ),
                ],
              ),
            ),
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
                            child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),

                            ),
                          ),
                        ),
                        Expanded(
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Text(
                                'Enter your credentials to continue',
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      icontop: Icon(Icons.account_circle_outlined),
                      labelInput: 'Name',
                      hinttext: false,
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      icontop: Icon(Icons.email_outlined),
                      labelInput: 'Email',
                      hinttext: false,
                      controller: _emailController,
                    ),
                  ),
                  Expanded(
                    child: InputForm(
                      icontop: Icon(Icons.lock_outline_sharp),
                      labelInput: 'Password',
                      hinttext: true,
                      controller: _passwordController,
                    ),
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: 0.8,
                      widthFactor: 0.9,
                      child: ElevatedButton(
                        onPressed: _signUp,
                        child: FractionallySizedBox(
                          heightFactor: 0.3,
                          widthFactor: 0.5,
                          child: FittedBox(
                            child: Text('Sign Up',
                            style: TextStyle(color: Colors.black),),
                          ),
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
                    ),
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      alignment: Alignment.topCenter,
                      heightFactor: 0.5,
                      widthFactor: 0.6,
                      child: FittedBox(
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?',
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).pushNamed('$Login');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({
    Key? key,
    required this.icontop,
    required this.labelInput,
    required this.hinttext,
    this.controller,
  }) : super(key: key);

  final Icon icontop;
  final String labelInput;
  final bool hinttext;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.75,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
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
                      color: Colors.grey,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
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
                  controller: controller,
                  obscureText: hinttext,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    height: 2.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    label: Text(labelInput),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(18),
                        topRight: Radius.circular(18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight, screenWidth;
  bool remember = false;
  TextEditingController emailCtrller = TextEditingController();
  TextEditingController passwordCtrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 52, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                height: screenHeight / 2.5,
                width: screenWidth,
                child: Image.asset(
                    'assets/images/MY Tutor-logos_transparent.png')),
            const Text(
              "Login",
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            Row(
              children: [
                Checkbox(value: remember, onChanged: _onRememberMe),
                const Text("Remember Me")
              ],
            ),
            SizedBox(
                width: screenWidth,
                height: 50,
                child: ElevatedButton(
                  child: const Text("Login"),
                  onPressed: _loginUser,
                ))
          ]))
    ])));
  }

  void _onRememberMe(bool? value) {
    setState(() {
      remember = value!;
    });
  }

  void _loginUser() {}
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_tutor/views/loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late double screenHeight, screenWidth;
  bool remember = false;
  TextEditingController nameCtrller = TextEditingController();
  TextEditingController emailCtrller = TextEditingController();
  TextEditingController phoneCtrller = TextEditingController();
  TextEditingController passwordCtrller = TextEditingController();
  TextEditingController addressCtrller = TextEditingController();


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
              "Register",
              style: TextStyle(fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                controller: nameCtrller,
                decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                controller: emailCtrller,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                controller: passwordCtrller,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                controller: phoneCtrller,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextField(
                controller: addressCtrller,
                decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 20,),
              Row(children: [
                const Text("Already Register?",
                  style: TextStyle(fontSize: 16.0, )),
                  GestureDetector(
                    onTap: _loginPage,
                    child: const Text("Login here",
                    style: TextStyle(fontSize: 16.0,
                    fontWeight: FontWeight.bold),
                    )
                  )
              ],
            ),  
            SizedBox(
                width: screenWidth,
                height: 50,
                child: ElevatedButton(
                  child: const Text("Register"),
                  onPressed: _registerUser,
                ))
          ]))
    ])));
  }

void _loginPage(){
  Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (content) => const LoginScreen()));
}

void _registerUser() {
  FocusScope.of(context).requestFocus(FocusNode());
  String _name = nameCtrller.text;
  String _email = emailCtrller.text;
  String _password = passwordCtrller.text;
  String _phone = phoneCtrller.text;
  String _address = addressCtrller.text;

  http.post(Uri.parse("http://10.31.210.250/mytutor/mobile/php/register_user.php"),
    body: {"name": _name, "email": _email, "password": _password, "phone": _phone, "address": _address}).then((response) {
      print(response.body);
    });
}
}
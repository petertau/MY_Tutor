import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Calculator")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
              child: Column(children: const [
            TextField(),
            TextField(),
            MaterialButton(
              onPressed: null,
              child: Text("+"),
            )
          ])),
          const Text("Result")
        ]),
      ),
    );
  }
}

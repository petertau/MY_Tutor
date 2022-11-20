import 'dart:convert';
import 'package:ndialog/ndialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoPage(),
    );
  }
}

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  String selectLoc = "eth", description = "No value entered";

  var name, unit, value, type;
  List<String> locList = [
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jyp",
    "krw",
    "kwd",
    "ikr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Crypto APP")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Simple Crypto App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const TextField(
              controller: null,
              keyboardType: TextInputType.numberWithOptions(),
            ),
            DropdownButton(
              itemHeight: 60,
              value: selectLoc,
              onChanged: (newValue) {
                setState(() {
                  selectLoc = newValue.toString();
                });
              },
              items: locList.map((selectLoc) {
                return DropdownMenuItem(
                  child: Text(
                    selectLoc,
                  ),
                  value: selectLoc,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadCrypto, child: const Text("Load Crypto")),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ],
        )));
  }

  Future<void> _loadCrypto() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData['rates']['eth']['name'];
      unit = parsedData['rates']['eth']['unit'];
      value = parsedData['rates']['eth']['value'];
      type = parsedData['rates']['eth']['type'];
      setState(() {
        description =
            "The current weather in $selectLoc is $name. It feels like $unit. The current temperature is $value Celcius and humidity is $type percent. ";
      });
      progressDialog.dismiss();
    }
  }
}

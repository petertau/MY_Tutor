import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_tutor/models/tutor.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

void main() => runApp(const TutorListScreen());

class TutorListScreen extends StatelessWidget {
  const TutorListScreen({Key? key}) : super(key: key);

  static const String _title = 'MY Tutor';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyTutorListScreen(),
    );
  }
}

class MyTutorListScreen extends StatefulWidget {
  const MyTutorListScreen({Key? key}) : super(key: key);

  @override
  State<MyTutorListScreen> createState() => _MyTutorListScreenState();
}

class _MyTutorListScreenState extends State<MyTutorListScreen> {
   List<Tutor> tutorList = <Tutor>[];
   late double screenHeight, screenWidth, resWidth;
   String titlecenter = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadTutors();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600){
      resWidth = screenWidth;
    }else{
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY Tutor'),
      ),
    body: tutorList.isEmpty
      ? Center(
        child: Text(titlecenter,
          style: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold)))
        :Column(
            children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("Tutors Available",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
      Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(tutorList.length, (index) {
                        return Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/tutors/" +
                                      tutorList[index].tutorId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Text(
                                tutorList[index].tutorName.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                tutorList[index].tutorEmail.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ));
                         }),
                      )
    )]));
  }

  void _loadTutors() {
    http.post(Uri.parse("http://10.31.210.250/mytutor/mobile/php/load_tutors.php"),
      body: {}).then((response){
        var jsondata = jsonDecode(response.body);

        if(response.statusCode == 200 && jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          if (extractdata['tutors'] !=null) {
            tutorList = <Tutor>[];
            extractdata['tutors'].forEach((v){
            tutorList.add(Tutor.fromJson(v));
          });
        }
        }
      });
  }
  }
  
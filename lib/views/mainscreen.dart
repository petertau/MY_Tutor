import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_tutor/views/tutorlistscreen.dart';
import '../models/subject.dart';
import '../constants.dart';


void main() => runApp(const MainScreen());

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String _title = 'MY Tutor';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyMainScreen(),
    );
  }
}

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({Key? key}) : super(key: key);

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  List<Subject> subjectList = <Subject>[];
  late double screenHeight, screenWidth, resWidth;
  String titlecenter = "Loading...";
  int _currentIndex = 0;
  
  final tabs = [
    Center(child: Text('Home')),
    TutorListScreen(),
    Center(child: Text('Home')),
    Center(child: Text('Home')),
  ];
  

   @override
  void initState() {
    super.initState();
    _loadSubjects();
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tutors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Subscribe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
          }
          );
        } 
      ),
      body: subjectList.isEmpty
      ? Center(
        child: Text(titlecenter,
          style: const TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold)))
        :Column(
            children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("Subjects Available",
              style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
        Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1),
                      children: List.generate(subjectList.length, (index) {
                        return Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: CONSTANTS.server +
                                      "/mytutor/mobile/assets/courses/" +
                                      subjectList[index].subjectId.toString() +
                                      '.png',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Text(
                                subjectList[index].subjectName.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Column(children: [
                                              Text("RM " +
                                                  double.parse(
                                                          subjectList[index]
                                                              .subjectPrice
                                                              .toString())
                                                      .toStringAsFixed(2)),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ));
                         }),
                      )
    )]));
  }
  

  void _loadSubjects() {
    http.post(Uri.parse("http://10.31.210.250/mytutor/mobile/php/load_subjects.php"),
      body: {}).then((response){
        var jsondata = jsonDecode(response.body);

        if(response.statusCode == 200 && jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          if (extractdata['subjects'] !=null) {
            subjectList = <Subject>[];
            extractdata['subjects'].forEach((v){
            subjectList.add(Subject.fromJson(v));
          });
        }
        }
      });
  }
}

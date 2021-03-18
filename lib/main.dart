import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/blankAppBar.dart';
import 'package:flutter_web/courseSimulator/courseSimulator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Min Gwang',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'no title'),
      initialRoute: 'home',
      routes: {
        'home':(context) => MyHomePage(),
        'course_simulator':(context) => CourseSimulator(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _counter = 0;


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> addFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    File file;
    if(result != null){
      file = File(result.files.single.path);
    }
    else{
      file = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlankAppBar(),
      body: Center(
        child: ElevatedButton(
          child: Text('Start'),
          onPressed: (){
            Navigator.of(context).pushNamed('course_simulator');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: addFile,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

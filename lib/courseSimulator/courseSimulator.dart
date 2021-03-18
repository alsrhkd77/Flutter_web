import 'package:flutter/material.dart';
import 'package:flutter_web/courseSimulator/courseBloc.dart';
import 'package:flutter_web/courseSimulator/courseSimulatorGradePage.dart';

class CourseSimulator extends StatefulWidget {
  @override
  _CourseSimulatorState createState() => _CourseSimulatorState();
}

class _CourseSimulatorState extends State<CourseSimulator>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final CourseBloc courseBloc = new CourseBloc();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //title: Text('Course Build Simulator', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        title: ListTile(
          title: Text('Course Build Simulator',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          trailing: Wrap(
            children: [
              Text('공통교양: -19.00점\t'),
              Text('공학소양: -4.00점\t'),
              Text('BSM: -18.00점\t'),
              Text('인증필수: -21.00점\t'),
              Text('인증 선택: -60.00점\t'),
              Text('졸업 요구: -140.00점'),
            ],
          ),
        ),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            child: Text(
              '1학년',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              '2학년',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              '3학년',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              '4학년',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]),
        centerTitle: true,
      ),
      body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            CourseSimulatorGradePage(courseBloc: courseBloc, selectedGrade: 1,),
            CourseSimulatorGradePage(courseBloc: courseBloc, selectedGrade: 2,),
            CourseSimulatorGradePage(courseBloc: courseBloc, selectedGrade: 3,),
            CourseSimulatorGradePage(courseBloc: courseBloc, selectedGrade: 4,),
          ]),
    );
  }
}

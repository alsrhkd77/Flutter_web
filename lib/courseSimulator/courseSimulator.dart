import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/courseSimulator/courseBloc.dart';
import 'package:flutter_web/courseSimulator/courseSimulatorGradePage.dart';
import 'package:flutter_web/courseSimulator/courseSimulatorResultPage.dart';

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
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          subtitle: Text('* 17학번부터 적용'),
          trailing: OutlinedButton(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text('완 료'),
            ),
            onPressed: () {
              List<List<List<CompilationSubject>>> _list;
              Map<String, double> _score;
              _list = courseBloc.getResultSubject();
              _score = courseBloc.getResultScore();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CourseSimulatorResultPage(
                            courseList: _list,
                            score: _score,
                          )));
            },
          ),
          /*
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
           */
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
            CourseSimulatorGradePage(
              courseBloc: courseBloc,
              selectedGrade: 1,
            ),
            CourseSimulatorGradePage(
              courseBloc: courseBloc,
              selectedGrade: 2,
            ),
            CourseSimulatorGradePage(
              courseBloc: courseBloc,
              selectedGrade: 3,
            ),
            CourseSimulatorGradePage(
              courseBloc: courseBloc,
              selectedGrade: 4,
            ),
          ]),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add custom subject',
        elevation: 5.0,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final subjectFormKey = new GlobalKey<FormState>();
                String _subjectName = '';
                String _subjectCredit = '';
                String _semester = '1학기';
                String _process = '자율교양';
                String _err = '';
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.all(15.0),
                    actionsPadding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Text('교과목 추가'),
                    content: Container(
                      width: 350,
                      height: 350,
                      child: Form(
                        key: subjectFormKey,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text('과목명'),
                              title: TextFormField(
                                maxLength: 30,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '과목명'),
                                validator: (value) =>
                                    value.isEmpty ? '과목명을 입력해주세요!' : null,
                                onSaved: (value) => _subjectName = value,
                              ),
                            ),
                            ListTile(
                              leading: Text('학점'),
                              title: TextFormField(
                                maxLength: 10,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp('^[0-9]{1,2}\.?[0-9]{0,2}'))
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '00.00'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return '학점을 입력해주세요!';
                                  } else if (double.parse(value) <= 0.0) {
                                    return '0점 이상의 학점을 입력해주세요!';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) => _subjectCredit = value,
                              ),
                            ),
                            ListTile(
                              leading: Text('개설 학기'),
                              title: DropdownButton(
                                isExpanded: true,
                                isDense: false,
                                onChanged: (value) {
                                  setState(() {
                                    _semester = value;
                                  });
                                },
                                value: _semester,
                                items: Course.semester.keys
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                              ),
                            ),
                            ListTile(
                              leading: Text('이수 구분'),
                              title: DropdownButton(
                                isExpanded: true,
                                isDense: false,
                                value: _process,
                                items: Course.completionProcess.keys
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _process = value;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.warning,
                                color: _err == ''
                                    ? Color.fromRGBO(255, 255, 255, 0.0)
                                    : Colors.red,
                              ),
                              title: Text(
                                _err,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Cancel'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String result;
                          final formKey = subjectFormKey.currentState;
                          if (formKey.validate()) {
                            formKey.save();
                            result = courseBloc.addCustomSubject(_subjectName,
                                _subjectCredit, _semester, _process);
                            if (result == '') {
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                _err = result;
                              });
                            }
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text('Save'),
                        ),
                      ),
                    ],
                  );
                });
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

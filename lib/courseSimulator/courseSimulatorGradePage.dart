import 'package:flutter/material.dart';
import 'package:flutter_web/blankAppBar.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/courseSimulator/courseBloc.dart';

class CourseSimulatorGradePage extends StatelessWidget {
  CourseBloc courseBloc;
  int selectedGrade;

  CourseSimulatorGradePage({Key key, this.courseBloc, this.selectedGrade});

  Widget subjectCard(CompilationSubject item, int selectedSemester) {
    bool selected = true;
    if (item.selectedGrade == 0 || item.selectedSemester == 0) {
      selected = false;
    }
    return Container(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        child: Container(
          ///테두리
          decoration: BoxDecoration(
              border: Border.all(
                  color: courseBloc.checkAntecedentSubject(item)
                      ? (selected ? Colors.greenAccent : Colors.blueAccent)
                      : Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          padding: EdgeInsets.all(15.0),
          width: 280.0,
          height: 150.0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///체크박스
                  selected
                      ? Icon(
                          Icons.check_box_rounded,
                          color: Colors.greenAccent,
                        )
                      :
                      //Icon(Icons.check_box_outline_blank_rounded, color: Colors.greenAccent,),
                      Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: Colors.grey,
                        ),

                  ///선행과목 표시
                  Course.antecedentSubject.containsKey(item.subjectName)
                      ? IconButton(
                          //불투명
                          icon: Icon(
                            Icons.circle_notifications,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {},
                          tooltip:
                              '\n선행 과목\n${Course.antecedentSubject[item.subjectName]}\n',
                        )
                      : Container(
                          //투명
                          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                          child: Icon(
                            Icons.circle_notifications,
                            color: Color.fromRGBO(255, 255, 255, 0.0),
                          ),
                        ),
                ],
              ),
              ListTile(
                title: Text(item.subjectName),
                subtitle:
                    Text('${item.ABEEKProcess} / ${item.completionProcess}'),
                trailing: Text('${item.credit.toString()}학점'),
              )
            ],
          ),
        ),
        onTap: () {
          if (courseBloc.checkAntecedentSubject(item)) {
            if (selected) {
              courseBloc.unselectSubject(item);
            } else {
              courseBloc.selectSubject(item, selectedGrade, selectedSemester);
            }
          }
        },
      ),
    );
  }

  List<Widget> buildSubjectCardList(Map data, int semester) {
    List<Widget> _subjectCards = [];
    for (CompilationSubject item in data.values) {
      if ((item.recommendedGrade == selectedGrade ||
              item.recommendedGrade == 0) &&
          (item.semester == 0 || item.semester == semester)) {
        if (item.selectedGrade != 0 && item.selectedSemester != 0) {
          if (item.selectedGrade == selectedGrade &&
              item.selectedSemester == semester) {
            Widget _card = subjectCard(item, semester);
            _subjectCards.add(_card);
          }
        } else {
          Widget _card = subjectCard(item, semester);
          _subjectCards.add(_card);
        }
      }
    }
    return _subjectCards;
  }

  List<Widget> buildScoreList(Map data, Map ref) {
    List<Widget> _result = [];
    for (String _key in ref.keys) {
      Text _item = new Text(
        '$_key ${data[_key]}/${ref[_key]} 학점',
        style: TextStyle(
          fontSize: 15.0,
            color: (data[_key] - ref[_key]) >= 0 ? Colors.green : Colors.red),
      );
      _result.add(_item);
    }
    return _result;
  }

  Widget scoreCard(BuildContext context) {
    return StreamBuilder(
        stream: courseBloc.scoreStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  padding: EdgeInsets.fromLTRB(55.0, 25.0, 25.0, 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '공학인증 요구 조건',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 15.0,
                            children: buildScoreList(
                                snapshot.data, Course.ABEEKProcess),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '졸업 요구 조건',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Wrap(
                            spacing: 15.0,
                            children: buildScoreList(
                                snapshot.data, Course.completionProcess),
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: courseBloc.calculate,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text('새로고침'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: courseBloc.initCourseBloc,
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Text('전체 초기화'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlankAppBar(),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: courseBloc.selectedItemStream,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      scoreCard(context),
                      Divider(),
                      Container(
                        padding: EdgeInsets.fromLTRB(55.0, 25.0, 25.0, 0.0),
                        alignment: Alignment.centerLeft,
                        child: Text('1학기'),
                      ),
                      Container(
                        padding: EdgeInsets.all(25.0),
                        child: Wrap(
                          children: buildSubjectCardList(snapshot.data, 1),
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.fromLTRB(55.0, 25.0, 25.0, 0.0),
                        alignment: Alignment.centerLeft,
                        child: Text('2학기'),
                      ),
                      Container(
                        padding: EdgeInsets.all(25.0),
                        child: Wrap(
                          children: buildSubjectCardList(snapshot.data, 2),
                        ),
                      ),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}

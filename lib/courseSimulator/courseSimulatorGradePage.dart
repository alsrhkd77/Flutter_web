import 'package:flutter/material.dart';
import 'package:flutter_web/blankAppBar.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/courseSimulator/courseBloc.dart';

class CourseSimulatorGradePage extends StatelessWidget {
  CourseBloc courseBloc;
  int selectedGrade;

  CourseSimulatorGradePage({Key key, this.courseBloc, this.selectedGrade});

  Widget subjectCard(CompilationSubject item, bool selected) {
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
              courseBloc.selectSubject(item);
            }
          }
        },
      ),
    );
  }

  List<Widget> buildSubjectCardList(Map data, int semester) {
    List<Widget> _subjectCards = [];
    for (CompilationSubject key in data.keys) {
      if (key.recommendedGrade == selectedGrade &&
          (key.semester == 0 || key.semester == semester)) {
        Widget _card = subjectCard(key, data[key]);
        _subjectCards.add(_card);
      }
    }
    return _subjectCards;
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

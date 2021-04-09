import 'package:flutter/material.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/courseSimulator/courseBloc.dart';

class CourseSimulatorResultPage extends StatefulWidget {

  final args;

  CourseSimulatorResultPage({this.args});

  @override
  _CourseSimulatorResultPageState createState() =>
      _CourseSimulatorResultPageState();
}

class _CourseSimulatorResultPageState extends State<CourseSimulatorResultPage> {
  CourseBloc _bloc;
  List<String> _associated = [];
  List courseList = [];
  Map score = {};

  @override
  void initState() {
    super.initState();
    _bloc = widget.args;
    courseList = _bloc.getResultSubject();
    score = _bloc.getResultScore();
  }

  ListView buildListView(
      BuildContext context, List<CompilationSubject> subjectList) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: subjectList.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            selected: _associated.contains(subjectList[index].subjectName),
            onTap: () {
              if (Course.antecedentSubject
                  .containsKey(subjectList[index].subjectName)) {
                setState(() {
                  _associated.add(subjectList[index].subjectName);
                  _associated.addAll(
                      Course.antecedentSubject[subjectList[index].subjectName]);
                });
              } else {
                setState(() {
                  _associated.clear();
                });
                for (String _subject in Course.antecedentSubject.keys) {
                  if (Course.antecedentSubject[_subject]
                      .contains(subjectList[index].subjectName)) {
                    setState(() {
                      _associated.add(_subject);
                      _associated.add(subjectList[index].subjectName);
                    });
                  }
                }
              }
            },
            title: Text(subjectList[index].subjectName),
            subtitle: Text(
                '${subjectList[index].ABEEKProcess} / ${subjectList[index].completionProcess}'),
            trailing: Text('${subjectList[index].credit.toString()}학점'),
          );
        });
  }

  List buildContent(BuildContext context) {
    List<Widget> result = [];
    List<List<double>> score = _bloc.getCreditsByGrade();
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 2; j++) {
        Container temp = Container(
          padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width / 8,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                child: Text(
                  '${i + 1}학년 ${j + 1}학기',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
              ),
              Container(
                margin: EdgeInsets.all(3.0),
                child: Text('수강학점: ${score[i][j]}점'),
              ),
              buildListView(context, courseList[i][j]),
            ],
          ),
        );
        result.add(temp);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(
          title: Text('Course Build Simulator',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          subtitle: Text('* 17학번부터 적용'),
        ),
        centerTitle: true,
      ),
      body: _bloc == null ? CircularProgressIndicator() : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildContent(context),
        ),
      ),
    );
  }
}

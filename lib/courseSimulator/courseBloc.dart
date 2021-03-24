import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:rxdart/rxdart.dart';

class CourseBloc {
  Map<String, CompilationSubject> _selected;
  Map<String, double> _score;

  BehaviorSubject _selectedItemBehavior =
      new BehaviorSubject<Map<String, CompilationSubject>>();
  BehaviorSubject _scoreBehavior = new BehaviorSubject<Map<String, double>>();

  Stream get selectedItemStream => _selectedItemBehavior.stream;

  Stream get scoreStream => _scoreBehavior.stream;

  CourseBloc() {
    initCourseBloc();
  }

  initCourseBloc() {
    _selected = Map.fromIterable(Course.subjects,
        key: (i) => i.subjectName, value: (i) => i);
    for (CompilationSubject _subject in _selected.values) {
      _subject.selectedGrade = 0;
      _subject.selectedSemester = 0;
    }
    _selectedItemBehavior.sink.add(_selected);

    _score = new Map();
    _score.addAll(Course.ABEEKProcess);
    _score.addAll(Course.completionProcess);
    _score.updateAll((key, value) => 0);
    _scoreBehavior.sink.add(_score);
  }

  calculate() {
    _score = new Map();
    _score.addAll(Course.ABEEKProcess);
    _score.addAll(Course.completionProcess);
    _score.updateAll((key, value) => 0);

    for (CompilationSubject _subject in _selected.values) {
      if (_subject.selectedSemester != 0 && _subject.selectedGrade != 0) {
        _score[_subject.ABEEKProcess] += _subject.credit;
        _score[_subject.completionProcess] += _subject.credit;
      }
    }

    _scoreBehavior.sink.add(_score);
  }

  selectSubject(CompilationSubject _subject, int _grade, int _semester) {
    _selected[_subject.subjectName].selectedGrade = _grade;
    _selected[_subject.subjectName].selectedSemester = _semester;
    _score[_subject.ABEEKProcess] += _subject.credit;
    _score[_subject.completionProcess] += _subject.credit;

    _selectedItemBehavior.sink.add(_selected);
    _scoreBehavior.sink.add(_score);
  }

  unselectSubject(CompilationSubject _subject) {
    _selected[_subject.subjectName].selectedGrade = 0;
    _selected[_subject.subjectName].selectedSemester = 0;
    _score[_subject.ABEEKProcess] -= _subject.credit;
    _score[_subject.completionProcess] -= _subject.credit;
    for (String _item in Course.antecedentSubject.keys) {
      if (Course.antecedentSubject[_item].contains(_subject.subjectName)) {
        _selected[_item].selectedGrade = 0;
        _selected[_item].selectedSemester = 0;
        _score[_selected[_item].ABEEKProcess] -= _selected[_item].credit;
        _score[_selected[_item].completionProcess] -= _selected[_item].credit;
      }
    }
    _selectedItemBehavior.sink.add(_selected);
    _scoreBehavior.sink.add(_score);
  }

  bool checkAntecedentSubject(CompilationSubject _item) {
    if (Course.antecedentSubject.containsKey(_item.subjectName)) {
      for (String _subject in Course.antecedentSubject[_item.subjectName]) {
        if (_selected[_subject].selectedSemester == 0 ||
            _selected[_subject].selectedGrade == 0) {
          return false;
        }
      }
    }
    return true;
  }

  dispose() {
    _selectedItemBehavior.close();
    _scoreBehavior.close();
  }
}

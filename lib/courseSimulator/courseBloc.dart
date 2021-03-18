import 'package:flutter_web/common/course.dart';
import 'package:flutter_web/common/compilationSubject.dart';
import 'package:rxdart/rxdart.dart';

class CourseBloc {
  Map<CompilationSubject, bool> _selected;

  BehaviorSubject _selectedItemBehavior =
      new BehaviorSubject<Map<CompilationSubject, bool>>();

  Stream get selectedItemStream => _selectedItemBehavior.stream;

  CourseBloc() {
    initCourseBloc();
  }

  initCourseBloc() {
    _selected =
        Map.fromIterable(Course.subjects, key: (i) => i, value: (i) => false);
    _selectedItemBehavior.sink.add(_selected);
  }

  selectSubject(CompilationSubject _subject) {
    _selected[_subject] = true;
    _selectedItemBehavior.sink.add(_selected);
  }

  unselectSubject(CompilationSubject _subject) {
    _selected[_subject] = false;
    _selectedItemBehavior.sink.add(_selected);
  }

  bool checkAntecedentSubject(CompilationSubject _item) {
    if (Course.antecedentSubject.containsKey(_item.subjectName)) {
      for (String _subject in Course.antecedentSubject[_item.subjectName]) {
        for (CompilationSubject c in _selected.keys) {
          if (c.subjectName == _subject && !_selected[c]) {
            return false;
          }
        }
      }
    }
    return true;
  }

  dispose() {
    _selectedItemBehavior.close();
  }
}

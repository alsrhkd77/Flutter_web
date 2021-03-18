import 'package:flutter_web/common/compilationSubject.dart';

class Course {
  static final Map<String, int> ABEEKProcess = {
    //ABEEK 구분
    '전문교양': 0,
    '인증필수': 0,
    '인증선택': 0,
    'BSM': 0,
    '공학소양': 4
  };

  static final Map<String, int> completionProcess = {
    //이수 구분
    '공통교양': 19,
    '전공필수': 21,
    '전공선택': 60
  };

  static final Map<String, List<String>> antecedentSubject = {
    //선행 과목
    '컴퓨터구조이론및실습': ['이산수학'],
    '운영체제': ['컴퓨터구조이론및실습'],
    '컴퓨터알고리즘': ['데이터구조'],
    '데이터구조': ['이산수학', '프로그래밍실습2'],
    '파일처리론': ['데이터구조'],
    '데이터베이스이론및실습': ['데이터구조'],
    '캡스톤디자인2': ['캡스톤디자인1'],
    '캡스톤디자인1': ['소프트웨어설계공학', '비주얼프로그래밍'],
    '소프트웨어설계공학': ['이산수학'],
    '비주얼프로그래밍': ['프로그래밍실습2'],
    '프로그래밍실습2': ['프로그래밍실습1'],
  };

  static final List<CompilationSubject> subjects = [
    //편성 과목
    //1-1
    CompilationSubject('콜라보인성의이해', 100129, '전문교양', '공통교양', 1, 1, 1),
    CompilationSubject('기본영어', 100108, '전문교양', '공통교양', 1, 3, 1),
    CompilationSubject('논리적사유와글쓰기', 100110, '전문교양', '공통교양', 1, 3, 1),
    CompilationSubject('전공탐색과생애설계 1-1', 100111, '전문교양', '공통교양', 1, 1, 1),
    CompilationSubject('컴퓨터개론', 400506, '인증필수', '전공필수', 1, 3, 1),
    CompilationSubject('프로그래밍실습1', 401428, '인증필수', '전공필수', 1, 3, 1),

    //1-2
    CompilationSubject('영어회화', 100030, '전문교양', '공통교양', 2, 3, 1),
    CompilationSubject('문학과삶\n(슬로리딩)', 100128, '전문교양', '공통교양', 2, 2, 1),
    CompilationSubject('철학의향기와역사이야기', 100120, '전문교양', '공통교양', 2, 3, 1),
    CompilationSubject('전공탐색과생애설계1-2', 100112, '전문교양', '공통교양', 2, 1, 1),
    CompilationSubject('이산수학', 400346, 'BSM', '전공필수', 2, 3, 1),
    CompilationSubject('프로그래밍실습2', 401429, '인증필수', '전공필수', 2, 3, 1),

    //2-1
    CompilationSubject('전공탐색과진로설계2-1', 100113, '전문교양', '공통교양', 1, 0.5, 2),
    CompilationSubject('데이터구조', 400650, '인증필수', '전공필수', 1, 3, 2),
    CompilationSubject('공학설계입문', 400798, '인증필수', '전공필수', 1, 3, 2), //3학점 맞음? 3(2)로 되있던데
    CompilationSubject('생명과학개론', 400253, 'BSM', '전공선택', 1, 3, 2),
    CompilationSubject('컴퓨터그래픽스', 504779, '인증선택', '전공선택', 1, 3, 2),
    CompilationSubject('객체지향프로그래밍1', 505510, '인증선택', '전공선택', 1, 3, 2),
    CompilationSubject('확률및통계', 504597, 'BSM', '전공선택', 1, 3, 2),

    //2-2
    CompilationSubject('전공탐색과진로설계2-2', 100114, '전문교양', '공통교양', 2, 0.5, 2),
    CompilationSubject('컴퓨터구조이론및실습', 401475, '인증필수', '전공필수', 2, 3, 2),
    CompilationSubject('비주얼프로그래밍', 501703, '인증필수', '전공선택', 2, 3, 2), //3(1)
    CompilationSubject('컴퓨터네트워크', 503884, '인증선택', '전공선택', 2, 3, 2),
    CompilationSubject('파일처리론', 504062, '인증선택', '전공선택', 2, 3, 2),
    CompilationSubject('객체지향프로그래밍2', 505513, '인증필수', '전공선택', 2, 3, 2), //3(1)
    CompilationSubject('수치해석학', 507635, 'BSM', '전공선택', 2, 3, 2),

    //3-1
    CompilationSubject('지도교수세미나3-1', 100115, '전문교양', '공통교양', 1, 0.25, 3),
    CompilationSubject('운영체제', 502695, '인증선택', '전공선택', 1, 3, 3),
    CompilationSubject('인터넷프로그래밍', 502986, '인증선택', '전공선택', 1, 3, 3),
    CompilationSubject('멀티미디어시스템', 505297, '인증선택', '전공선택', 1, 3, 3),
    CompilationSubject('정보보호론', 505300, '인증선택', '전공선택', 1, 3, 3),
    CompilationSubject('소프트웨어설계공학', 506960, '인증필수', '전공선택', 1, 3, 3), //3(1)
    CompilationSubject('데이터베이스이론및실습', 509233, '인증선택', '전공선택', 1, 3, 3),

    //3-2
    CompilationSubject('지도교수세미나3-2', 100116, '전문교양', '공통교양', 2, 0.25, 3),
    CompilationSubject('시스템프로그래밍', 502220, '인증선택', '전공선택', 2, 3, 3),
    CompilationSubject('영상처리', 502591, '인증선택', '전공선택', 2, 3, 3),
    CompilationSubject('객체지향모델링', 506626, '인증필수', '전공선택', 2, 3, 3), //3(1)
    CompilationSubject('데이터베이스응용', 506923, '인증필수', '전공선택', 2, 3, 3), //3(1)
    CompilationSubject('컴퓨터알고리즘', 506994, '인증선택', '전공선택', 2, 3, 3),
    CompilationSubject('모바일컴퓨팅', 509235, '인증선택', '전공선택', 2, 3, 3),
    CompilationSubject('캡스톤디자인1', 508707, '인증필수', '전공선택', 2, 1, 3), //1(1)

    //4-1
    CompilationSubject('지도교수세미나4-1', 100117, '전문교양', '공통교양', 1, 0.25, 4),
    CompilationSubject('컴파일러개론', 503865, '인증선택', '전공선택', 1, 3, 4),
    CompilationSubject('객체지향설계', 505711, '인증선택', '전공선택', 1, 3, 4), //3(1)
    CompilationSubject('임베디드소프트웨어', 506104, '인증선택', '전공선택', 1, 3, 4), //3(1)
    CompilationSubject('멀티미디어처리응용', 506933, '인증선택', '전공선택', 1, 3, 4),
    CompilationSubject('유비쿼터스응용시스템', 507573, '인증선택', '전공선택', 1, 3, 4),
    CompilationSubject('캡스톤디자인2', 506708, '인증필수', '전공선택', 1, 3, 4), //3(3)

    //4-2
    CompilationSubject('지도교수세미나4-2', 100118, '전문교양', '공통교양', 2, 0.25, 4),
    CompilationSubject('지능정보시스템', 503678, '인증선택', '전공선택', 2, 3, 4),
    CompilationSubject('인터넷창업및경영\n(산학연계학)', 508685, '인증선택', '전공선택', 2, 3, 4),
    CompilationSubject('프로그래밍언어개론', 509236, '인증선택', '전공선택', 2, 3, 4),
    CompilationSubject('융합소프트웨어특강', 510160, '인증선택', '전공선택', 2, 3, 4)
  ];
}

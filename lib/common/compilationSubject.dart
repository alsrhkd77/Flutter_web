class CompilationSubject{
  String subjectName;
  int subjectNumber;
  String ABEEKProcess;  //ABEEK 구분
  String completionProcess; //이수 구분
  int semester; //교과목이 편성된 학기 0=상시, 1=1학기, 2=2학기
  double credit; //학점
  int recommendedGrade; //추천 이수 학년
  CompilationSubject(this.subjectName, this.subjectNumber, this.ABEEKProcess, this.completionProcess, this.semester, this.credit, this.recommendedGrade);
}
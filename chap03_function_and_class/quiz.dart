void main(){

  Student student = new Student('김학생',18);
  Teacher teacher = new Teacher('김선생',50);


  teacher.greet();
  teacher.teach();
  student.greet();
  student.study();


}

class Person{

  String? name;
  int? age; 

  Person(this.name, this.age);

  void greet(){
    print('안녕하세요, ${name}입니다.');
  }

}

class Student extends Person{

  Student(String name, int age) : super(name, age);

  void study(){
    print('공부중입니다.');
  }

}

class Teacher extends Person{


  Teacher(String name, int age) : super(name, age);

  void teach(){

    print('가르치는 중입니다.');
  }
}
/**
   *  클래스는 변수와 함수들을 모아놓은, 객체를 만들기 위한 설계도이다.
   * 
   * 클래스의 구성 요소
   * 속성(property) : 클래스 내에서 선언한 변수는 지역변수 혹은 프로퍼티라 한다.
   * 메소드(Method) : 클래스 내의 함수
   * 생성자(Constructor) : 클래스명과 동일한 함수
   */
void main () {

  // 생성자를 사용해 인스턴스를 만들 수 있다.
  Human human = new Human('비비', 25);
  
  print('이름 : ${human.name}');

  // 인스턴스 에 내장된 함수를 사용할 수 있다.
  print(human.doHello());

  
}

/**
 * 클래스는 '카멜케이스'에 첫 문자도 대문자로 시작하는 '파스칼 케이스'로 작성
 */
class Human{

  //인스턴스 변수
  String name;
  int age;

  Human( this.name, this.age );

  getName(){
    this.name;
  }

  String doHello(){
    return "안녕하세요 ${name} 입니다.";
  }


}
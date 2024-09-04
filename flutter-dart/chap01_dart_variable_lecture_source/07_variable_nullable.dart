

void main () {

  /** 
  * 초기화를 하지 않아도 변수 선언을 할 수 있게 해주는 nullable
   */
  // String name;

  String? name;
  print(name);

  name = null;

  print('------------Null-aware operator----------');
  String? value1;
  String value2 = "not null";


  value1 ??= "null이여서 값이 할당됨";
  value2 ??= 'null이 아니어서 값이 할당되지 앖음';

  print(value1);
  print(value2);

}
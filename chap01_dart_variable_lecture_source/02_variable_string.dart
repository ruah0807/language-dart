/**
 다트의 변수명 규칙
 {영문, _, $, 숫자}만 가능하다.
 camelCase 를 사용한다.
  */

void main(){

/**
변수를 기본적으로 초기화하는 기본 형태는 다음과 같다.*/
/*[타입] [변수명] = [초기값]; */
  String name = 'Ruah.Kim';

/*** 문자열을 작성할 때는 작은따옴표'', 큰따옴표"" 둘다 가능 */

  String name1 = 'ruah.kim';
  String name2 = '김.루아';


  /** 문자열 안에 $[변수명] 을 통해 변수를 문자열 안에 바로 넣을 수 있다. */
  print('안녕하세요'+ name1);
  print('안녕하세요 $name2');
  print('안녕하세요+ ${name1 + name2}');


  /**
  각 타입에내장 함수가 존재한다.
   */
  print(name.split('.'));
  print(name1.toUpperCase());


}
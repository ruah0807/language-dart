// ignore_for_file: dead_code

/** 
 * 조건문 [if]문 : 조건에 따라 실행하고 싶은 코드를 나눌때 사용
 */

void main(){
  bool boolean = true;

  if(boolean) {
    print("boolean : $boolean" );
  }else{
    print("boolean : $boolean");
  }

  print('------elseif------');
  bool boolean1 = false;
  bool boolean2 = true;

  /**
   * 조건문은 else if 형태로 계속 조건을 추가 가능
   * 앞에서 부터 하나씩 비교하면서, 조건 하나라도 true로 실행되면 그 뒤에 조건문은 실행되지 않는다.
   */
  if(boolean1){
    //boolean1 이 true이면 진행
    print("boolean1 : $boolean1");
    
  }else if(boolean2){
    //boolean1이 false이고, boolean2가 true 이면 실행
    print("boolean2 : $boolean2");
    
  }else {
    print("boolean1과 2가 false 입니다.");
  }


}
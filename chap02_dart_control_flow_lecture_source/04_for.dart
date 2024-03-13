void main(){

  /**
   * 반목문 [for]문 : 특정 코드를 반복해서 실행하고 싶을 때 사용
   */
  for(var i =0; i <5; i++){
    print('hello $i');
  }

  print('----------for 문 list ----');
  List<String> foods = ["짜장면", "짬뽕", "탕수육", "양장피", "크림새우"];
  for (var i = 0; i < foods.length; i++) {
    print('food : ${foods[i]}');
  }

  /**
   * java의 향상된 for 문과 같이 배열에 있는 모든 값을 하나씩 변수로 받아와 코드를 실행시키는 
   * for in문
   */
  print('-----------for in 문 -----------');
  for (var food in foods) {
    print('food: $food');
  }

  /**
   * 
   */



}
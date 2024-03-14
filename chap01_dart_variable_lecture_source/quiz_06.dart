void main () {

  List<String> foods = ['순대볶음', '요거트', '고구마'];
  print(foods);

  foods[0] = '칼국수';
  print(foods);

  foods.remove('고구마');
  print(foods);


}
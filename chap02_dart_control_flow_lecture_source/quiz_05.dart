











void main (){

  List<int> numbers = [0,1,0];

  for (var i = 0; i < numbers.length; i++) {
    print(numbers[i]);
  }

  for (var number in numbers) {
    print(number);
  }
}
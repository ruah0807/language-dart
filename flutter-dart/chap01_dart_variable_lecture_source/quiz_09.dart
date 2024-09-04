
void main () {

  String? nullableString;

  if ( nullableString == null) {
    print("이 변수는 null입니다.");
  } else {
    print(nullableString);
  }

  nullableString ??= "이 변수는 null입니다.";
  print(nullableString);

  print(nullableString ?? '이변수는 널입니다.');



}
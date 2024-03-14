void main() {

  Map<String, dynamic> member = {'name':'Ruah Kim', 'age': 34, 'email' : 'kimhk0315@gmail.com'};
  print(member);

  member['email'] = 'khkz087@naver.com';
  print(member);

  member.update('email', (value) => 'hkz087@hanmail.net');
  print(member);

}
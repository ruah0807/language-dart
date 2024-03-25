import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

//로그인 담당 서비스
class AuthService extends ChangeNotifier {
  User? currentUser() {
    //현재 유저
  }

  /// 이름지정 매개변수
  /// 소괄호 안에 중활호를 넣고, 그 안에 매개변수를 넣어서 표현할 수 있다.
  /// 이름 지정 매개변수는 해당 이름으로 값을 받아오는 역할을 한다.
  //회원가입
  void signUp({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    //회원가입
    if (email.isEmpty) {
      onError('이메일을 입력하세요');
    } else if (password.isEmpty) {
      onError('비밀번호를 입력하세요');
      return;
    }

    // firebase auth 회원가입
    try {
      // 회원가입 시도
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //성공하면
      onSuccess;
    } on FirebaseAuthException catch (e) {
      // FireBase auth 에러 발생
      // ! => null을 강제로 벗겨준다.
      onError(e.message!);
    } catch (e) {
      // Firebase auth 이외의 에러 발생
      onError(e.toString());
    }
  }

  // 로그인
  void signIn({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    // 로그인
  }

  // 로그아웃
  void signOut() async {
    // 로그아웃
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

//로그인 담당 서비스
class AuthService extends ChangeNotifier {
  User? currentUser() {
    //현재 유저 가 확실히 로그인 되었는지 확인하기 위해 유저 정보 가져오기
    //로그인 유저정보 반환(로그인 되지 않으면 null 반환)
    return FirebaseAuth.instance.currentUser;
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
      onSuccess();
    } on FirebaseAuthException catch (e) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // 성공 함수 호출
        onSuccess();
      } on FirebaseAuthException catch (e) {
        // 에러메시지 한국어로 바꾸기
        if (e.code == 'weak-password') {
          onError('비밀번호를 6자리 이상 입력해 주세요.');
        } else if (e.code == 'email-already-in-use') {
          onError('이미 가입된 이메일 입니다.');
        } else if (e.code == 'invalid-email') {
          onError('이메일 형식을 확인해주세요.');
        } else if (e.code == 'user-not-found') {
          onError('일치하는 이메일이 없습니다.');
        } else if (e.code == 'wrong-password') {
          onError('비밀번호가 일치하지 않습니다.');
        } else {
          onError(e.message!);
        }

        // Firebase auth 에러 발생
        // ! => null을 강제로 벗겨준다.
        onError(e.message!);
      } catch (e) {
        // Firebase auth 이외의 에러 발생
        onError(e.toString());
      }
    }
  }

  // 로그인
  void signIn({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    if (email.isEmpty) {
      onError('이메일을 입력하세요');
    } else if (password.isEmpty) {
      onError('비밀번호를 입력하세요');
      return;
    }
    // 로그인 시도
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //성공시 호출
      onSuccess();

      //로그인 상태 변경 알림
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      //Firebase Auth 에러가 발생 했을 때
      onError(e.message!);
    } catch (e) {
      onError(e.toString());
    }
  }

  // 로그아웃
  void signOut() async {
    // 로그아웃

    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}

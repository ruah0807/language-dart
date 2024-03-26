import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ToDoService extends ChangeNotifier {
  //ChangeNotifier : 변경 사항 바로 바로 확인 가능
  final toDoCollection = FirebaseFirestore.instance.collection('toDo');

  //읽기
  // QuerySnapshot : 파이어베이스에서 쿼리를 실행한 결과로 반환되는 객체
  // 쿼리 결과로 반환된 여러 doc의 스냅샷을 가지고 있다.
  Future<QuerySnapshot> read(String uid) async {
    //내 todoList가져오기
    // throw UnimplementedError(); //임시로 return 값 미구현 에러

    // query문.
    return toDoCollection.where('uid', isEqualTo: uid).get();
  }

//     쓰기
  void create(String job, String uid) async {
    //   todo 만들기

    await toDoCollection.add({
      'uid': uid,
      'job': job,
      'isDone': false,
    });
    // 새로생긴건 화면에 다시 만들어줘야해서 notifyListener가 필요
    notifyListeners();
  }

//     변경
  void update(String docId, bool isDone) async {
    // todo isDone update
    await toDoCollection.doc(docId).update(
      {"isDone": isDone},
    );
    notifyListeners();
  }

  void delete(String docId) async {
    //   toDo 삭제

    await toDoCollection.doc(docId).delete();
    notifyListeners();
  }
}

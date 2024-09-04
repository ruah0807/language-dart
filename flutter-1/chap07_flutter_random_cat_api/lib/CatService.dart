import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatService extends ChangeNotifier {
  SharedPreferences prefs;
  List<String> catImages = [];
  List<String> favoriteCatImages = [];

  // CatService 생성자
  CatService(this.prefs) {
    getRandomCatImages();
    //저장된 값이 없을 때
    favoriteCatImages = prefs.getStringList('isFavorite') ?? [];
  }

  // 고양이 이미지 10개 가져오는 메서드
  void getRandomCatImages() async {
    String path =
        "https://api.thecatapi.com/v1/images/search?limit=10&mime_types=jpg";
    var result = await Dio().get(path);
    print(result.data);
    for (int i = 0; i < result.data.length; i++) {
      var map = result.data[i];
      print(map);
      print(map['url']);
      //catImage 에 이미지 url 추가( 지정해 준 path 안에는 json 형식으로 여러 가지 key 들이 모여있다. 그중 url 을 가져오는 것.)
      catImages.add(map['url']);
    }
    notifyListeners();
  }

  // catImage url 가져오기
  void toggleFavoriteImage(String catImage) {
    if (favoriteCatImages.contains(catImage)) {
      favoriteCatImages.remove(catImage);
    } else {
      favoriteCatImages.add(catImage);
    }

    //좋아요 한 이미지를 isFavorite 안에 저장해주기
    prefs.setStringList('isFavorite', favoriteCatImages);

    notifyListeners();
  }
}

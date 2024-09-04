import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CatService.dart';

class FavoriteCats extends StatefulWidget {
  const FavoriteCats({super.key});

  @override
  State<FavoriteCats> createState() => _FavoriteCatsState();
}

//상태 클래스
class _FavoriteCatsState extends State<FavoriteCats> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(builder: (context, catService, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Favorite Cats❤️',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(CupertinoIcons.chevron_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.brown,
        ),
        body: GridView.count(
          //크로스축으로 아이템이 2개씩 배치되도록 설정
          crossAxisCount: 2,
          // 그리드의 주축(세로) 사이의 아이템 공간 설정
          mainAxisSpacing: 8,
          // 그리드의 크로스축(가로) 사이의 아이템 공간 설정
          crossAxisSpacing: 8,
          //그리드 전체에 대한 패딩 설정
          padding: EdgeInsets.all(8),
          // 그리드에 표시될 위젯의 리스트, 10개의 위젯을 생성

          children: List.generate(catService.favoriteCatImages.length, (index) {
            String favoriteCats = catService.favoriteCatImages[index];

            // GestureDetector : 이미지를 선택할 수 있게 해준다.
            return GestureDetector(
              child: Stack(
                children: [
                  /**
                   * Positioned
                   *    Stack 내에서 자식 위젯의 위치를 정밀하게 제어할 때 사용
                   *    top, right, bottom, left 의 네가지 속성으로 위치를 조정한다.
                   * Positioned.fill -  4가지 속성이 모두 0으로 설정되며,
                   *                  Stack의 모든 면을 채우도록 설정 된다.
                   */
                  Positioned.fill(
                    child: Image.network(
                      favoriteCats,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(
                      Icons.favorite,
                      color: catService.favoriteCatImages.contains(favoriteCats)
                          ? Colors.red
                          : Colors.transparent,
                    ),
                  )
                ],
              ),
              onTap: () {
                //사진 클릭시 작동
                catService.toggleFavoriteImage(favoriteCats);
              },
            );
          }),
        ),
      );
    });
  }
}

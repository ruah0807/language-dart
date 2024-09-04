import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CatService.dart';
import 'FavoriteCats.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatService>(
      builder: (context, catService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '랜덤고양이',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.brown,
            actions: [
              IconButton(
                onPressed: () {
                  //   아이콘 버튼을 눌렀을 때 FavoriteCats 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => FavoriteCats()),
                  );
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.amber,
                ),
              )
            ],
          ),
          //GridView count 생성자로, 그리드 내 아이템 수를 기반으로 레이아웃을 구성할 수 있다.
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
            children: List.generate(catService.catImages.length, (index) {
              String catImage = catService.catImages[index];

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
                        catImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Icon(
                        Icons.favorite,
                        color: catService.favoriteCatImages.contains(catImage)
                            ? Colors.red
                            : Colors.transparent,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  //사진 클릭시 작동
                  catService.toggleFavoriteImage(catImage);
                },
              );
            }),
          ),
        );
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<Feed> createState() => _feedState();
}

class _feedState extends State<Feed> {
  // 좋아요 여부
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // 위치 정렬 왼쪽 스타트
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          widget.imageUrl, //hard코딩으로 말고 변수지정하여 불러오기
          //이미지 높이
          height: 400,
          // double.infinity : 위젯의 너비를 가능한 최대로 설정.
          width: double.infinity,
          // 전체 프레임을 채우기 위해 사진을 확대하거나 축소함.
          //사진이 프레임보다 작아도, 사진의 모양을 유지하면서 프레임의 모든 공간을 채우려고 자동으로 맞춤.
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                icon: Icon(CupertinoIcons.heart),
                color: isFavorite ? Colors.redAccent : Colors.black),
            IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.chat_bubble),
                color: Colors.black),
            Spacer(), // 오른 쪽 끝으로.
            IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.bookmark),
                color: Colors.black),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '3 likes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '네온과 고양이, 최고의 조합 😎 \n#CatLife #NeonVibes',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'March 6',
            style: TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}

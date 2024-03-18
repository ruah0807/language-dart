import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        //leading: 왼쪽
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              CupertinoIcons.bars,
              color: Color(0xff739072),
            ),
            onPressed: () {},
          ),
        ),

        // 오른쪽 가장자리
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.cart,
                color: Color(0xff739072),
              ),
              onPressed: () {},
            ),
          ),
        ],
        title: Center(
          child: Image.asset(
            'assets/images/logo1.png',
            scale: 5,
          ),
        ),
        flexibleSpace: Row(
          children: [
            FlexibleSpaceBar(
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              'https://mblogthumb-phinf.pstatic.net/MjAxODA2MzBfNTkg/MDAxNTMwMzI2NjQwOTIx.V2Vi9fi-77A0y4gFgpDi150YjEGnd2xk9H4y0MCUAmMg.tiU5xMaA44sUGo_XaQGii4mcqKGJExz2Q7lIzNyjEx8g.JPEG.flowervine/DSC00041.JPG?type=w800',
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.heart,
                    color: Color(0xff739072),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

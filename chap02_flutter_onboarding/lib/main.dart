import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences 인스턴스를 어디서든 접근 가능 하도록 전역 변수로 선언.
// late : 나중에 꼭 값을 할당 해준다는 의미
late SharedPreferences prefs;

void main() async {
  // main()에서 async 와 await 을 사용 하기 위해 필요한 함수
  WidgetsFlutterBinding.ensureInitialized();

  // Shared_preferences 인스턴스 생성   // await : 기다렸다가 실행
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SharedPreferences 에서 온보딩 완료 여부 조회
    // isOnboarded 에 해당하는 값에서 null을 반환하는 경우 false를 기본값으로 지정.
    bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Color.fromARGB(255, 36, 34, 34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // isOnboarded 값에 따라 Homepage 로 열지 TestScreen으로 열지 결정됨.
      home: isOnboarded ? HomePage() : TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Present, It still works',
      //textStyle
      titleTextStyle: TextStyle(
        color: Colors.amber,
        fontSize: 30,
        fontFamily: "IBMPlexSansKR",
        fontWeight: FontWeight.w400,
      ),
      subTitle:
          "I don't know what I study. please help me. I need your help for me",
      subTitleTextStyle: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontFamily: "IBMPlexSansKR",
          fontWeight: FontWeight.w100),
      imageUrl: 'assets/images/present.png',
    ),
    Introduction(
      title: '수료 후',
      //textStyle
      titleTextStyle: TextStyle(
        color: Colors.amber,
        fontSize: 30,
        fontFamily: "GasoekOne",
        // fontWeight: FontWeight.w100,
      ),
      subTitle: '현실에 아직 안 부딪혀봐서 일단 신남',
      imageUrl: 'assets/images/after.png',
    ),
    Introduction(
      title: 'After 10 years',
      //textStyle
      titleTextStyle: TextStyle(
        color: Colors.amber,
        fontSize: 30,
        fontFamily: "BlackHanSans",
        // fontWeight: FontWeight.w100,
      ),
      subTitle: '코딩을 엄청 잘하게 되어서 에러도 척척 해결해 시간이 남아돌게 되는......',
      imageUrl: 'assets/images/later.png',
    ),
    Introduction(
      title: '2 years ago',
      subTitle: '프로필 사진',
      imageUrl: 'assets/images/profile.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        // 마지막 페이지가 나오거나 skip 을 해서 homepage로 가기 전에 isOnboarded 를 true 로 바꿔준다.
        prefs.setBool('isOnboarded', true);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ), //MaterialPageRoute
        );
      },
      // foregroundColor: Colors.red,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('😡'), centerTitle: true, actions: [
        IconButton(
            onPressed: () {
              prefs.clear();
            },
            icon: Icon(Icons.delete))
      ]),
      body: Center(
        child: Text(
          '안녕하세요 루아입니다!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

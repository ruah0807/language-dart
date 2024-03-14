import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Color.fromARGB(255, 36, 34, 34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScreen(),
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      title: 'Present',
      subTitle: '코린이라 잘 모르는게 투성이',
      imageUrl: 'assets/images/present.png',
    ),
    Introduction(
      title: 'After study',
      subTitle: '현실에 아직 안 부딪혀봐서 일단 신난 루아',
      imageUrl: 'assets/images/after.png',
    ),
    Introduction(
      title: 'After 10 years',
      subTitle: '코딩을 엄청 잘하게 되어서 에러도 척척 해결해 시간이 남아도는 루아',
      imageUrl: 'assets/images/later.png',
    ),
    Introduction(
      title: '2 years ago',
      subTitle: 'Browse the menu and order directly from the application',
      imageUrl: 'assets/images/profile.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
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
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to Home Page!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

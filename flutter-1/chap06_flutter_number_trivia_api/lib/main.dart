import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//상태 클래스
class _HomePageState extends State<HomePage> {
  String quiz = '퀴즈';

  /**
    * initState() : stateful 위젯이 처음 생성될 때, 실행되는 함수
   */
  @override
  void initState() {
    super.initState();
    getQuiz();
    // 퀴즈 정보 불러와서 갱신하기
  }

  //Numbers API호출하기
  Future<String> getNumbertrivia() async {
    String path = 'http://numbersapi.com/random/trivia';
    Response result = await Dio().get(path);
    String trivia = result.data;
    print(trivia);
    return trivia;
  }

  void getQuiz() async {
    String trivia = await getNumbertrivia();
    setState(() {
      quiz = trivia;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.indigo,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            /**
             * 크로스 축이란?
             * 주축의 반대되는 축을 크로스 축이라고 한다.
             * Column의 주축은 세로방향이고, 크로스 축은 가로 방향이다.
             */
            // 크로스 축방향으로 가능한 많은 공간을 차지하게함.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /**
               * Extended 위젯
               * 레이아웃 위젯으로, 자식 위젯이 사용 가능한 추가 공간을 모두 차지 하도록 확장 시키는 역할
               * 주로, Row, Column 과 같은 레이아웃 위젯을 사용할 때, 내부의 자식 위젯들 사이의 공간을
               * 동적으로 분배할 목적으로 사용
               */
              Expanded(
                child: Center(
                  child: Text(
                    quiz,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              //퀴즈 생성 버튼
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    //버튼을 눌렀을 때 동작
                    getQuiz();
                  },
                  child: Text(
                    'New Quiz',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

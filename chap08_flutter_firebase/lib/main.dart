import 'package:chap08_flutter_firebase/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // FireBase 사용을 위해 가장 먼저 선언해 주어야 한다.
  WidgetsFlutterBinding.ensureInitialized();
  // firebase app 시작
  await Firebase.initializeApp();

  runApp(
    //서비스 등록
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()), // 외우기
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

//로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('로그인'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    '로그인 해주세요',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: '이메일'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(hintText: '비밀번호'),
                ),
                ElevatedButton(
                  onPressed: () {
                    //로그인 성공시 homepage로 이동
                    // pushReplacement : 뒤로 가기 기록이 사라짐.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    //회원가입창으로 이동
                    authService.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        //회원가입 성공

                        print('회원가입 성공');
                        //사용자가 볼 수 있는 snackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('회원가입 성공'),
                          ),
                        );
                      },
                      onError: (err) {
                        //에러 발생
                        print('회원가입 실패 : $err');

                        //사용자가 볼 수 있게
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(err),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

//홈페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoList'),
        actions: [
          TextButton(
            onPressed: () {
              //로그아웃 버튼을 눌렀을 때 로그인 페이지로 이동

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Text(
              '로그아웃',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(hintText: 'job을 입력해주세요'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // add 버튼을 눌렀을 때 job을 추가
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                String job = "$index";
                bool isDone = false;

                return ListTile(
                  title: Text(
                    job,
                    style: TextStyle(
                        fontSize: 24,
                        color: isDone ? Colors.grey : Colors.black,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.delete,
                    ),
                  ),
                  onTap: () {
                    //아이템을 클릭했을 때, isDone 상태 변경
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

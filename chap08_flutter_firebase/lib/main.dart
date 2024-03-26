import 'package:chap08_flutter_firebase/auth_service.dart';
import 'package:chap08_flutter_firebase/to_do_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        ChangeNotifierProvider(create: (context) => ToDoService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //유저는 변하지 않으니 final로 선언해준다.
    //다시 껐다 켜도 로그인이 되어있으니 홈페이지로 바로 들어가게 함.

    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : HomePage(),
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
        //로그인한 유저 객체 가져오기
        User? user = authService.currentUser();
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
                    //로그인 한 유저 정보보기
                    user == null ? '로그인 해주세요' : '${user.email}님 안녕하세요',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: '이메일'),
                ),
                TextField(
                  controller: passwordController,
                  //비밀번호 안보이게 하기
                  obscureText: true,
                  decoration: InputDecoration(hintText: '비밀번호'),
                ),
                ElevatedButton(
                  onPressed: () {
                    authService.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        //성공 메세지 띄우기
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('로그인성공'),
                          ),
                        );
                        //로그인 성공시 homepage로 이동
                        // pushReplacement : 뒤로 가기 기록이 사라짐.
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                        );
                      },
                      onError: (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(err),
                          ),
                        );
                      },
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
    return Consumer<ToDoService>(builder: (context, toDoService, child) {
      // 로그인한 회원정보를 가져오기 위해 위젯트리 최상단에서 가져옴
      //                          등록을 안해놨기 때문에 context.read 를 사용하여 최상단에서 가져옴
      AuthService authService = context.read<AuthService>();
      //  로그인시에만 HomePage에 접근 가능하기 때문에 User는 null이 될 수 없다.
      // 따라서 , !로 nullable을 지워준다.
      User? user = authService.currentUser()!;
      return Scaffold(
        appBar: AppBar(
          title: Text('TodoList'),
          actions: [
            TextButton(
              onPressed: () {
                //로그아웃 버튼을 눌렀을 때 로그인 페이지로 이동

                context.read<AuthService>().signOut();

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
                      if (jobController.text.isNotEmpty) {
                        toDoService.create(jobController.text, user.uid);
                      }
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
              /**
               * FutureBuilder
               * ToDoService read 기능을 반환하는 값이 시간이 걸리는 Future 여서 바로 화면에 보여줄 수 없다.
               * FutureBuilder 는 데이터를 요청할 때 builder 가 동작하고, 데이터를 받아왔을 때, 다시 builder 가 동작하여
               * 데이터를 받아온 뒤에 화면이 다시 그려지면서 데이터를 출력해 줄 수 있다.
               */
              child: FutureBuilder<QuerySnapshot>(
                  future: toDoService.read(user.uid),
                  builder: (context, snapshot) {
                    /**
                     * snapshot.data 는 값을 가지고 오는데 시간이 걸린다.
                     * docs의 경우 데이터가 있는 경우에만 호출이 가능하기 때문에 data뒤에 ? nullable을 지정해준다.
                     */
                    // 반환되는 값 // 데이터가 있으면 docs를 호출하고 없으면 빈배열 반환
                    final documents = snapshot.data?.docs ?? [];
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        String job = doc.get('job');
                        bool isDone = doc.get('isDone');

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
                            onPressed: () {
                              // 삭제 아이콘 눌렀을 때 동작
                              toDoService.delete(doc.id);
                            },
                            icon: Icon(
                              CupertinoIcons.delete,
                            ),
                          ),
                          onTap: () {
                            //아이템을 클릭했을 때, isDone 상태 변경
                            toDoService.update(doc.id, !isDone);
                          },
                        );
                      },
                    );
                  }),
            )
          ],
        ),
      );
    });
  }
}

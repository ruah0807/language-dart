import 'package:flutter/cupertino.dart';
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

//stf : StatefulWedget 자동완성 키
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _State();
}

// 상태 클래스
class _State extends State<HomePage> {
  List<ToDo> toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          "ToDoList",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: toDoList.isEmpty
          ? Center(
              child: Text("To Do List를 작성해주세요"),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                ToDo toDo = toDoList[index];

                return ListTile(
                  title: Text(
                    toDo.job,
                    style: TextStyle(
                      fontSize: 20,
                      color: toDo.isDone ? Colors.grey : Colors.black,
                      decoration: toDo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('삭제하시겠습니까?'),
                              actions: [
                                //취소버튼
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '취소',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )),
                                //삭제버튼
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        toDoList.removeAt(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '삭제',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ))
                              ],
                            );
                          });
                    },
                    icon: Icon(CupertinoIcons.delete),
                  ),
                  onTap: () {
                    setState(() {
                      toDo.isDone = !toDo.isDone;
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? job = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreatePage()),
            );
            if (job != null) {
              setState(() {
                ToDo newToDo = ToDo(job, false);
                toDoList.add(newToDo);
              });
            }
          },
          child: Icon(Icons.add)),
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  //TextField의 값을 가져올 때 사용
  TextEditingController textController = TextEditingController();

  //경고메세지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(
          'ToDoList 작성 페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              // 전 페이지로 이동
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.chevron_back) // 뒤로 가기 화살표 모양 변경
            ),
      ),
      body: Column(
        children: [
          //텍스트 입력창
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              //화면이 나왔을 경우, 입력창에 커서가 바로 오게 하는 기능.
              autofocus: true,
              decoration: InputDecoration(
                hintText: '할 일을 입력하세요',
                //유효성 검사 같은? 에러 메세지 띄우기
                errorText: error, //
              ),
            ),
          ),

          // Row, Column등에서 widget 사이에 빈 공간을 넣기 위해 사용
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //sizedBox : child widget의 size를 강제하기 위해
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  //추가하기 버튼을 클릭하면 작동
                  String toDo = textController.text;
                  if (toDo.isEmpty) {
                    setState(() {
                      error = "내용을 입력해 주세요";
                    });
                  } else {
                    setState(() {
                      error = null;
                    });
                  }
                  Navigator.pop(context, toDo);
                },
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//ToDo 클래스

class ToDo {
  String job;
  bool isDone;

  ToDo(this.job, this.isDone);
}

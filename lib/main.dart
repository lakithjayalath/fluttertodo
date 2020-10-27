import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertodoapp/firestoreservice.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'taskscreen.dart';
import 'task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      //home: CreateToDo(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> items;
  FirestoreService fireServ = new FirestoreService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items = new List();

    todoTasks?.cancel();

    todoTasks = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Task> tasks = snapshot.documents
      .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
      .toList();

      setState(() {
        this.items = tasks;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 80.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  shadowColor: Color(0x802196F3),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          todoType('${items[index].tasktype}'),
                                          Text(
                                            '${items[index].taskname}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                '${items[index].taskdate}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                '${items[index].tasktime}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.0
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],)
                  ],);
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFA7397),
        child: Icon(
          FontAwesomeIcons.listUl,
          color: Color(0xFFFDDE42),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskScreen(Task('', '', '', '', '')),
                fullscreenDialog: true
              )
          );
        },
      ),
    );
  }
}


Widget todoType(String iconType) {
  IconData iconVal;
  Color colorVal;
  switch (iconType) {
    case 'travel':
      iconVal = FontAwesomeIcons.mapMarkedAlt;
      colorVal = Color(0xff4158ba);
      break;
    case 'shopping':
      iconVal = FontAwesomeIcons.shoppingCart;
      colorVal = Color(0xfffb537f);
      break;
    case 'gym':
      iconVal = FontAwesomeIcons.dumbbell;
      colorVal = Color(0xff4caf50);
      break;
    case 'party':
      iconVal = FontAwesomeIcons.glassCheers;
      colorVal = Color(0xff9962d0);
      break;
    default:
      iconVal = FontAwesomeIcons.tasks;
      colorVal = Color(0xff0dc8f5);
  }

  return CircleAvatar(
    backgroundColor: colorVal,
    child: Icon(iconVal, color: Colors.white, size: 20.0),
  );
}


Widget _myAppBar(context) {
  return Container(
    height: 80.0,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.blue,
      // gradient: LinearGradient(
      //   colors: [
      //     const Color(0xFFFA7397),
      //     const Color(0xFFFDDE42),
      //   ],
      //   begin: const FractionalOffset(0.0, 0.0),
      //   end: const FractionalOffset(1.0, 0.0),
      //   stops: [0.0, 1.0],
      //   tileMode: TileMode.clamp
      // )
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                  onPressed: () {

                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'ToDo Tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {

                  },
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}


//class CreateToDo extends StatefulWidget {
//   @override
//  _CreateToDoState createState() => _CreateToDoState();
//}
//
//class _CreateToDoState extends State<CreateToDo> {
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      //resizeToAvoidBottomInset: false,
//      body: Column(
//        children: <Widget>[
//          _myAppBar(context),
//          Center(child: Text('Todo Task'),),
//        ],
//      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color(0xFFFA7397),
//        child: Icon(
//          FontAwesomeIcons.listUl,
//          color: Color(0xFFFDDE42),
//        ),
//        onPressed: () {
//          //Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen()),
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                builder: (context) => NewTask(),
//                fullscreenDialog: true
//              )
//          );
//        },
//      ),
//    );
//  }
//}
//
//Widget _myAppBar(context) {
//  return Container(
//    height: 80.0,
//    width: MediaQuery.of(context).size.width,
//    decoration: BoxDecoration(
//      gradient: LinearGradient(
//        colors: [
//          const Color(0xFFFA7397),
//          const Color(0xFFFDDE42)
//        ],
//        begin: const FractionalOffset(0.0, 0.0),
//        end: const FractionalOffset(1.0, 0.0),
//        stops: [0.0, 1.0],
//        tileMode: TileMode.clamp
//      ),
//    ),
//    child: Padding(
//      padding: const EdgeInsets.only(top: 16.0),
//      child: Center(
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            Expanded(
//              flex: 1,
//              child: Container(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.arrowLeft,
//                    color: Colors.white,
//                  ),
//                  onPressed: () {
//
//                  },
//                ),
//              ),
//            ),
//            Expanded(
//              flex: 5,
//              child: Container(
//                child: Text(
//                  'ToDo Tasks',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontWeight: FontWeight.bold,
//                    fontSize: 20.0
//                  ),
//                ),
//              ),
//            ),
//            Expanded(
//              flex: 1,
//              child: Container(
//                child: IconButton(
//                  icon: Icon(
//                    FontAwesomeIcons.search,
//                    color: Colors.white,
//                  ),
//                  onPressed: () {
//                    //
//                  },
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    ),
//  );
//}
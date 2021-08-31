import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:s_m_system/SignIn.dart';
import 'package:s_m_system/TeacherSignUp.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),

    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tabs Demo'),
          ),

          body: Column(
            children: [
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0),
                  child: Row(
                    children: [
                      Text("Name"),
                      SizedBox(width: 250,),
                      Icon(Icons.mail),
                    ],
                  ),
                ),
              ),
              Text("Designation"),
              SizedBox(height: 30,),
              Divider(color: Colors.blue,),
              TabBar(labelColor: Colors.blueAccent,
                tabs: [
                  Tab(icon: Icon(Icons.directions_car), text: "Routine"),
                  Tab(icon: Icon(Icons.directions_transit),text: "Results"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Table(
                    border: TableBorder.all(color: Colors.white),
                // columnWidths: const <int, TableColumnWidth>{
                //   0: IntrinsicColumnWidth(),
                //   1: FlexColumnWidth(64),
                //   2: FixedColumnWidth(64),
                // },
                // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Container(
                        height: 64,
                        color: Colors.green,
                      ),
                      Container(
                        height: 64,
                        color: Colors.red,
                      ),
                      Container(
                        height: 64,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  TableRow(
                    // decoration: const BoxDecoration(
                    //   //color: Colors.grey,
                    // ),
                    children: <Widget>[
                      Container(
                        height: 64,
                        color: Colors.purple,
                      ),
                      Container(
                        height: 64,

                        color: Colors.yellow,
                      ),
                      Container(
                        height: 64,

                        color: Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
                    Icon(Icons.directions_transit),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:s_m_system/SignIn.dart';

import 'Profile.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String data1;
  String data2, morning1, morning2, noon1, noon2, sub1, sub2, sub3, sub4;

  _fetch()async{

    final User user = await FirebaseAuth.instance.currentUser;

    if(user!=null){
      await FirebaseFirestore.instance
          .collection("Student")
          .doc(user.uid)
          .get()
          .then((value){
        data1 = value ['SName'];
        data2 = value['SId'];
      }).catchError((e){
        print(e);
      });
    }
  }

  getData() async{
    // var document = FirebaseFirestore.instance.collection('Routine').doc("Routine");
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Routine").doc("Routine").get();
    if(documentSnapshot.exists){
      setState(() {
        Map<String, dynamic>  data = documentSnapshot.data();
        morning1 = data['Morning1'];
        morning2 = data['Morning2'];
        noon1 = data['Noon1'];
        noon2 = data['Noon2'];

        sub1 = data['Sub1'];
        sub2 = data['Sub2'];
        sub3 = data['Sub3'];
        sub4 = data['Sub4'];
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Student Home Page'),
        ),

        body: Column(
          children: [
      FutureBuilder(
      future: _fetch(),
      builder: (context, snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          return Text("Loading Data");
        }
        return Center(
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.only(left:100.0, right: 100),
                child: TextFormField(
                  initialValue: data1,
                  decoration: InputDecoration(
                    labelText: 'Teacher Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left:100.0, right: 100),
                child: TextFormField(
                  initialValue: data2,
                  decoration: InputDecoration(
                    labelText: 'Teacher Id',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
            FlatButton(onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StudentProfile()));
              });
            }, child: Text("Profile", style: TextStyle(color: Colors.white),),
              color: Colors.lightGreen,
            ),
            Divider(color: Colors.blue,),
            TabBar(labelColor: Colors.blueAccent,
              tabs: [
                Tab(icon: Icon(Icons.note), text: "Routine"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.white),
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            height: 64,
                            width: 32,
                            color: Color(0xFF76A3F1),
                            child: Text("  Day/\n  Time", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF76A3F1),
                            child: Text("10-12 PM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF76A3F1),
                            child: Text("12-2 PM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
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
                            width: 32,
                            color: Color(0xFF76A3F1),
                            child: Text("  SAT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF0DC789),
                            child: Column(
                              children: [
                                Text(morning1  ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                Text(sub1  ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                              ],
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF0DC789),
                            child: Column(
                              children: [
                                Text(noon1 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                Text(sub2 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                              ],
                            ),
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
                            width: 32,
                            color: Color(0xFF76A3F1),
                            child: Text("  SUN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),

                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF0DC789),
                            child: Column(
                              children: [
                                Text(morning2 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                Text(sub3 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                              ],
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Color(0xFF0DC789),
                            child: Column(
                              children: [
                                Text(noon2 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                Text(sub4 ?? "Loading\n", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FlatButton(onPressed: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              });
            }, child: Text("Log out"))
          ],
        ),
      ),
    );
  }
}


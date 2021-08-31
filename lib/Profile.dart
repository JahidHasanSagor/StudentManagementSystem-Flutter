import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s_m_system/HomePage.dart';
import 'package:s_m_system/sHomePage.dart';


class StudentProfile extends StatefulWidget {
  const StudentProfile({Key key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String name, semester, studentId, subject, result;

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  void save() async{
    User user =  await FirebaseAuth.instance.currentUser;
    firestore.collection('Student').doc(user.uid).set({
      'SName' : name,
      'SId' : studentId,
      'Subject' : subject,
      'Semester' : semester,
      'Result' : result,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile"),),
      backgroundColor: Color(0xFF57AD7E),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Name",
                  labelStyle: TextStyle( color: Colors.white),
                ),
                onChanged: (input){
                  name = input;
                },
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Semester",
                  labelStyle: TextStyle( color: Colors.white),
                ),
                onChanged: (input){
                  semester = input;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Student ID",
                  labelStyle: TextStyle( color: Colors.white),
                ),
                onChanged: (input){
                  studentId = input;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Subject",
                  labelStyle: TextStyle( color: Colors.white),
                ),
                onChanged: (input){
                  subject = input;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Result",
                  labelStyle: TextStyle( color: Colors.white),
                ),
                onChanged: (input){
                  result = input;
                },
              ),
            ),

            SizedBox(height: 20),

            FlatButton(
              color: Colors.white,
              child: Text("Update Profile"),
              onPressed: (){
                setState(() {
                  save();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomePage()));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";


import 'HomePage.dart';
import 'SignIn.dart';
import 'TeacherSignUp.dart';


class TeacherSignIn extends StatefulWidget {
  const TeacherSignIn({Key key}) : super(key: key);

  @override
  _TeacherSignInState createState() => _TeacherSignInState();
}

class _TeacherSignInState extends State<TeacherSignIn> {
  String dropdownValue = 'Student';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email;
  String teacherId;
  String teacherName;
  String _password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future <void> signIn() async {
    final formState = _globalKey.currentState;
    if(formState.validate()){
      formState.save();
    }
    try{
      User user = (await _firebaseAuth.signInWithEmailAndPassword(email: _email, password: _password)).user;
      save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherHomePage()));
    }
    catch(e){
      print(e);
    }
  }

  Future<void> save() async {
    User user =  await FirebaseAuth.instance.currentUser;
    firestore.collection('Teacher').doc(user.uid).set({
      'TeacherName' : teacherName,
      'TeacherId' : teacherId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Row(
        children: [
          SizedBox(width: 55,),
          Text("Teacher Sign In",style: TextStyle(fontSize: 25),),
        ],
      ), backgroundColor: Color(0xFF1AA76A)),
      backgroundColor: Color(0xff1aa76a),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,top: 120,right: 20),
          child: Form(
            key: _globalKey,
            child: (
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Text("Welcome,", style: TextStyle(
                              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(width: 90,),
                            TextButton(
                                onPressed: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherSignUp()));
                                  });
                                  },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white,style: BorderStyle.solid, width: 1.5)
                                  ),
                                  child: Text("Sign Up",
                                    style: TextStyle(fontSize: 25,color: Colors.white),),
                                ))
                          ],
                        ),
                      ],
                    ),
                    Text("Sign in to Continue",
                      style: TextStyle(
                          color: Colors.white
                      ),),

                    SizedBox(height: 30,),
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onSaved: (input){
                        _email = input;
                      },
                      validator: (input){
                        if(input.isEmpty){
                          return "Please provide valid email";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white
                            )
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      obscureText: true,

                      onSaved: (input){
                        _password = input;
                      },

                      validator: (input) {
                        if (input.length < 5) {
                          return "Please provide at least 6 characters";
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),

                    Align(alignment: Alignment.centerRight, child: new Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.white
                      ),)),

                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 36,

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,style: BorderStyle.solid, width: 2.0)
                          ),
                          child: DropdownButton<String>(
                            dropdownColor: Color(0xFF1AA76A),
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward, color: Colors.white,),
                            iconSize: 24,
                            elevation: 16,
                            underline: Container(
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                switch(dropdownValue){
                                  case "Student":
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                                    break;
                                  case "Teacher":
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherSignIn()));
                                    break;
                                }
                              });
                            },
                            items: <String>['Student', 'Teacher' ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                              );
                            })
                                .toList(),
                          ),
                        ),
                        SizedBox(width: 10,),
                        FlatButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            color: Colors.white, onPressed: (){
                          setState(() {
                            signIn();
                          });
                        }, child: Text("GET STARTED",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green))
                        ),
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),

    );
  }
}

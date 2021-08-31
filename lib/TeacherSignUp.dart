import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'SignIn.dart';
import 'TeacherSignIn.dart';
class TeacherSignUp extends StatefulWidget {
  const TeacherSignUp({Key key}) : super(key: key);

  @override
  _TeacherSignUpState createState() => _TeacherSignUpState();
}

class _TeacherSignUpState extends State<TeacherSignUp> {
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
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _password)).user;
      save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherSignIn()));
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
          Text("Teacher Sign Up",style: TextStyle(fontSize: 25),),
        ],
      ), backgroundColor: Color(0xFF1AA76A)),
      backgroundColor: Color(0xff1aa76a),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,top: 80,right: 20),
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
                    Text("Create your new account",
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
                        labelText: "Teacher Name",
                        labelStyle: TextStyle( color: Colors.white),
                      ),
                      onSaved: (input){
                        teacherName = input;
                      },
                      validator: (input){
                        if(input.isEmpty){
                          return "Please provide valid name";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
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
                        labelText: "Teacher ID",
                        labelStyle: TextStyle( color: Colors.white),
                      ),
                      onSaved: (input){
                        teacherId = input;
                      },
                      validator: (input){
                        if(input.isEmpty){
                          return "Please provide valid ID";
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
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
                        labelText: "Email",
                        labelStyle: TextStyle( color: Colors.white),
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
                      style: TextStyle(color: Colors.white),
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
                        labelStyle: TextStyle(color: Colors.white),

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
                      style: TextStyle(color: Colors.white),
                    ),

                    Align(alignment: Alignment.centerRight, child: new Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.white
                      ),)),

                    SizedBox(height: 30,),

                    Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                              minWidth: MediaQuery.of(context).size.width,
                              color: Colors.white, onPressed: (){
                            setState(() {
                              signIn();
                            });
                          }, child: Text("GET STARTED",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green))
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),
                  ],
                )
            ),
          ),
        ),
      ),

    );
  }
}

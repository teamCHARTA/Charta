import 'package:charta/functions/Signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool Userrolecheck =false;
String Userroll="user";
class User{
  String role;
  User({
    this.role="",
});
  Map<String,dynamic> toJson()=>{
    'role':role
  };

  static User fromJson(Map<String,dynamic>json)=>User(
    role:json['role']
  );
}
class Database{

  Future<void> Userdatawrite(String uid,String role )async {
    return await FirebaseFirestore.instance.collection("user").doc(uid).set({
      "role":role,
    }).then((value) => Newrollupdate(1));
  }

  Future ReadUserdata(uid)async{
  try{
    final Usercol =await FirebaseFirestore.instance.collection("user").doc(uid);
    final snapshot = await Usercol.get();
    if(snapshot.exists){
      Userrolecheck=true;
      final usser=User.fromJson(snapshot.data()!);
      Userroll=usser.role;
    }
  }catch(e){print(e.toString());return null;}
  }
  bool UserRollcheck(uid){
     ReadUserdata(uid);
    return Userrolecheck;
  }

  String UserRole(uid){
    ReadUserdata(uid);
    return Userroll;
  }



}
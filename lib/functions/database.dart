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

// Product data map
class Product{
  String productid;
  String uploaderid;
  int quality;
  int size;
  String uploadeddateandtime;


  Product({
    this.productid="",
    this.uploaderid="",
    this.quality=0,
    this.size=0,
    this.uploadeddateandtime="",


  });
  Map<String,dynamic> toJson()=>{
    'productid':productid,
    'uploaderid':uploaderid,
    'quality':quality,
    'size':size,
    'uploadeddateandtime':uploadeddateandtime,

  };

  static User fromJson(Map<String,dynamic>json)=>User(
      // productid:json['productid']
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

  Future<String> UserRole() async {
    String uid=  await FirebaseAuth.instance.currentUser!.uid;
    ReadUserdata(uid);
    return Userroll;
  }
  Future WritePaperData(quality,size,uid)async{
    await FirebaseFirestore.instance.collection("paperdata").doc().set({
      "productid": DateTime.now().millisecondsSinceEpoch.toString(),
      "user":uid,
      "quality":quality,
      "size":size,
      "time":DateTime.now().toString(),

    }).then((value) => print("Added"));
    
  }





}
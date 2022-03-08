import 'dart:io';
import 'dart:typed_data';

import 'package:charta/functions/Signin.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool Userrolecheck =false;
String Userroll="user";
List buyedproducts=[];
List selledproduct=[];
List scrapindproduct=[];
class User{
  String role;
  String userid;
  String loc;
  List buyedproducts;
  List selledproduct;
  List scrapindproduct;
  User({
    this.role="",
    this.userid="",
    this.loc="",
    required this.scrapindproduct,
    required this.selledproduct,
    required this.buyedproducts,

});
  Map<String,dynamic> toJson()=>{
    'role':role,
    'user':userid,
    'location':loc,
    'scrapinglist':scrapindproduct,
    'selledproduct':selledproduct,
    'buyedproducts':buyedproducts,

  };

  static User fromJson(Map<String,dynamic>json)=>User(
    role:json['role'],
    userid:json['user'],
    loc:json['location'],
    buyedproducts:json['buyedproducts'],
    selledproduct:json['selledproduct'],
    scrapindproduct:json['scrapinglist'],

  );
}

// Product data map
class Product{

  String productid;
  String uploaderid;
  String url1;
  String url2;
  int quantity;
  int usedpersent;
  var uploadeddateandtime;


  Product({
    this.productid="",
    this.uploaderid="",
    this.url1="",
    this.url2="",
    this.quantity=0,
    this.usedpersent=0,
    this.uploadeddateandtime,


  });
  Map<String,dynamic> toJson()=>{
    'productid':productid,
    'uploaderid':uploaderid,
    'url1':url1,
    'url2':url2,
    'quantity':quantity,
    'usedpersent':usedpersent,
    'uploadeddateandtime':uploadeddateandtime,

  };

  static Product fromJson(Map<String,dynamic>json)=>Product(
      productid:json['productid'],
      uploaderid:json['uploaderid'],
      url1: json['url1'],
      url2: json['url2'],
      quantity:json['quantity'],
      usedpersent:json['usedpersent'],
      uploadeddateandtime:json['uploadeddateandtime']
  );
}

class Appdata{
  int totalpaper;
  int totalscrappaper;
  int totaluser;

  Appdata({

    this.totalpaper=0,
    this.totalscrappaper=0,
    this.totaluser=0,


  });
  Map<String,dynamic> toJson()=>{

    'totalpaper':totalpaper,
    'totalscrappaper':totalscrappaper,
    'totaluser':totaluser,

  };

  static Appdata fromJson(Map<String,dynamic>json)=>Appdata(
      totalpaper:json['totalpaper'],
      totalscrappaper:json['totalscrappaper'],
      totaluser:json['totaluser'],

  );
}
class Database{

  Future<void> Userdatawrite(String role )async {
    var uid=FirebaseAuth.instance.currentUser?.uid;
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
      buyedproducts=usser.buyedproducts;
      selledproduct=usser.selledproduct;
      scrapindproduct=usser.scrapindproduct;


    }
  }catch(e){print(e.toString());return null;}
  }
  bool UserRollcheck(uid){
     ReadUserdata(uid);
    return Userrolecheck;
  }

  Future UserRole() async {
    String uid =  await FirebaseAuth.instance.currentUser!.uid;
    ReadUserdata(uid);
    return Userroll;
  }
  Future WritePaperData(quantity,usedpersent,url1,url2)async{
    String id=DateTime.now().millisecondsSinceEpoch.toString();
     var uid=FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection("paperdata").doc(id).set({
      "productid": id,
      "uploaderid":uid,
      "url1":url1,
      "url2":url2,
      "quantity":quantity,
      "usedpersent":usedpersent,
      "uploadeddateandtime":DateTime.now(),

    }).then((value) => print("Added"));
    
  }
  Future WriteuserData(quality,size,uid)async{
    await FirebaseFirestore.instance.collection("user").doc(uid).set({
      "buyedproducts":buyedproducts,
      "selledproduct":selledproduct,
      "scrapindproduct":scrapindproduct,
      "user":uid,
      "quality":quality,
      "size":size,
      "time":DateTime.now().toString(),

    }).then((value) => print("Added"));

  }
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }




}
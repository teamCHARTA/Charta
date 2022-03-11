import 'dart:io';

import 'dart:typed_data';

import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/roles.dart';
import 'package:charta/screens/Crudscreens/Addproduct.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
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
  int totalseller;

  Appdata({

    this.totalpaper=0,
    this.totalscrappaper=0,
    this.totaluser=0,
    this.totalseller=0,


  });
  Map<String,dynamic> toJson()=>{

    'totalpaper':totalpaper,
    'totalscrappaper':totalscrappaper,
    'totaluser':totaluser,
    'totalseller':totalseller,

  };

  static Appdata fromJson(Map<String,dynamic>json)=>Appdata(
      totalpaper:json['totalpaper'],
      totalscrappaper:json['totalscrappaper'],
      totaluser:json['totaluser'],
      totalseller:json['totalseller'],

  );
}
class Database{

  Future<void> Userdatawrite(String role)async {
    var uid=FirebaseAuth.instance.currentUser?.uid;
    return await FirebaseFirestore.instance.collection("user").doc(uid).set({
      "role":role,
      "buyedproducts":buyedproducts,
      "selledproduct":selledproduct,
      "scrapindproduct":scrapindproduct,
      "user":uid,
     // 'location':loc,
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

    }).then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"added"));
    
  }
  // Future WriteuserData(quality,size,uid)async{
  //   await FirebaseFirestore.instance.collection("user").doc(uid).set({
  //     "buyedproducts":buyedproducts,
  //     "selledproduct":selledproduct,
  //     "scrapindproduct":scrapindproduct,
  //     "user":uid,
  //     'role':role,
  //     'user':userid,
  //     'location':loc,
  //
  //
  //   }).then((value) => print("Added"));
  //
  // }
  Future UpdateuserData(quality,size,uid)async{
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "buyedproducts":buyedproducts,
      "selledproduct":selledproduct,
      "scrapindproduct":scrapindproduct,
      "user":uid,
      "quality":quality,
      "size":size,
      "time":DateTime.now().toString(),

    }).then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"added"));

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

  Stream <List<Product>> ReadSellerpaper() {

      var uid = FirebaseAuth.instance.currentUser?.uid;
      String? uuid=uid;
      print(uuid);
    return FirebaseFirestore.instance.collection('paperdata').where("uploaderid",isEqualTo:uuid).orderBy("uploadeddateandtime",descending: true).
        snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }
    // FirebaseFirestore.instance.collection('paperdata').where("uploderid",isEqualTo:uid)
    //     .snapshots()
    //     .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  Stream <List<Product>> ReadUserpaper() {
    return FirebaseFirestore.instance.collection('paperdata').where("usedpersent",isNotEqualTo: 100).orderBy("usedpersent",descending: true).orderBy("uploadeddateandtime",descending: true).
    snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }
  Stream <List<Product>> ReadAppdata()=>
      FirebaseFirestore.instance.collection('paperdata')
          .snapshots()
          .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365)
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    if (diff.inDays > 30)
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    if (diff.inDays > 7)
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    if (diff.inDays > 0)
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    if (diff.inHours > 0)
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    if (diff.inMinutes > 0)
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    return "just now";
  }

  void Snakebar(BuildContext? context,String message){
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context!)
        .showSnackBar(snackbar);
  }
}
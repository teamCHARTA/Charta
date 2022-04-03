import 'dart:io';
import 'dart:typed_data';
import 'package:charta/functions/Signin.dart';
import 'package:charta/gmapservices/locationservices.dart';
import 'package:charta/screens/Rollspage/roles.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../screens/Detailpage/Scraperorderpaperdetails.dart';
import '../screens/Detailpage/sellerorderpaperdetails.dart';
bool Userrolecheck =false;
String Userroll="user";
int prevquantity=0;
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
//userorderedpaper
class Usserorder{

  String productid;
  String sellerid;
  int quantity;
  var Buyedtime;


  Usserorder({
    this.productid="",
    this.sellerid="",
    this.quantity=0,
    this.Buyedtime,


  });
  Map<String,dynamic> toJson()=>{
    'productid':productid,
    'sellerid':sellerid,
    'quantity':quantity,
    'Buyedtime':Buyedtime,

  };

  static Usserorder fromJson(Map<String,dynamic>json)=>Usserorder(
      productid:json['productid'],
      sellerid:json['sellerid'],
      quantity:json['quantity'],
      Buyedtime:json['Buyedtime']
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
  double lat;
  double lon;
  String Adress;

  Product({
    this.productid="",
    this.uploaderid="",
    this.url1="",
    this.url2="",
    this.quantity=0,
    this.usedpersent=0,
    this.uploadeddateandtime,
    this.lon=0.0,
    this.lat=0.0,
    this.Adress="",
  });
  Map<String,dynamic> toJson()=>{
    'productid':productid,
    'uploaderid':uploaderid,
    'url1':url1,
    'url2':url2,
    'quantity':quantity,
    'usedpersent':usedpersent,
    'uploadeddateandtime':uploadeddateandtime,
    'lat':lat,
    'lon':lon,
    'Adress':Adress,

  };

  static Product fromJson(Map<String,dynamic>json)=>Product(
      productid:json['productid'],
      uploaderid:json['uploaderid'],
      url1: json['url1'],
      url2: json['url2'],
      quantity:json['quantity'],
      usedpersent:json['usedpersent'],
      uploadeddateandtime:json['uploadeddateandtime'],
      lat:json['lat'],
      lon:json['lon'],
      Adress: json['Adress']
  );
}

class userOrder{

  String productid;
  String parentproductid;
  String sellerid;
  String url1;
  String url2;
  double lat;
  double lon;
  String Adress;
  int quantity;
  int usedpersent;
  var Buyedtime;


  userOrder({
    this.productid="",
    this.parentproductid="",
    this.sellerid="",
    this.url1="",
    this.url2="",
    this.quantity=0,
    this.usedpersent=0,
    this.Buyedtime,
    this.lon=0.0,
    this.lat=0.0,
    this.Adress="",


  });
  Map<String,dynamic> toJson()=>{
    'parentproductid':parentproductid,
    'productid':productid,
    'uploaderid':sellerid,
    'url1':url1,
    'url2':url2,
    'quantity':quantity,
    'usedpersent':usedpersent,
    'uploadeddateandtime':Buyedtime,
    'lat':lat,
    'lon':lon,
    'Adress':Adress,
  };

  static userOrder fromJson(Map<String,dynamic>json)=>userOrder(
      productid:json['productid'],
      parentproductid:json['parentproductid'],
      sellerid:json['sellerid'],
      url1: json['url1'],
      url2: json['url2'],
      quantity:json['quantity'],
      usedpersent:json['usedpersent'],
      Buyedtime:json['Buyedtime'],
      lat:json['lat'],
      lon:json['lon'],
      Adress: json['Adress']
  );
}


class SellerOrder{
  double lat;
  double lon;
  String Adress;
  String productid;
  String parentproductid;
  String buyerid;
  String url1;
  String url2;
  int quantity;
  int usedpersent;
  var Buyedtime;


  SellerOrder({
    this.parentproductid="",
    this.lon=0.0,
    this.lat=0.0,
    this.Adress="",
    this.productid="",
    this.buyerid="",
    this.url1="",
    this.url2="",
    this.quantity=0,
    this.usedpersent=0,
    this.Buyedtime,


  });
  Map<String,dynamic> toJson()=>{
    'parentproductid':parentproductid,
    'productid':productid,
    'uploaderid':buyerid,
    'url1':url1,
    'url2':url2,
    'quantity':quantity,
    'usedpersent':usedpersent,
    'uploadeddateandtime':Buyedtime,
    'lat':lat,
    'lon':lon,
    'Adress':Adress,

  };

  static SellerOrder fromJson(Map<String,dynamic>json)=>SellerOrder(
      parentproductid:json['parentproductid'],
      productid:json['productid'],
      buyerid:json['buyerid'],
      url1: json['url1'],
      url2: json['url2'],
      quantity:json['quantity'],
      usedpersent:json['usedpersent'],
      Buyedtime:json['Buyedtime'],
      lat:json['lat'],
      lon:json['lon'],
      Adress: json['Adress']
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

  Future Readpaperdata()async{
    try{
      final paper=await FirebaseFirestore.instance.collection("paperdata").doc();
      final snapshot = await paper.get();
      if(snapshot.exists){
        final paper=Product.fromJson(snapshot.data()!);
        return paper;
      }
    }catch(e){print(e.toString());return null;}
  }
  Future Scanreadpaper(String id,BuildContext context)async{
    print("indb");
    print(id);

    String uid= await FirebaseAuth.instance.currentUser!.uid;

      final paper=await FirebaseFirestore.instance.collection("user").doc(uid).collection("orderedproduct").doc(id);
      final snapshot = await paper.get();
      if(snapshot.data()!=null){
      if(snapshot.data()!.isNotEmpty){
        final paper=SellerOrder.fromJson(snapshot.data()!);
        Navigator.push(
            context,( MaterialPageRoute(builder: (context)=>Sellerorderpaperdetails(
          value: id,
          url1: paper.url1,
          url2: paper.url2,
          productid: paper.productid,
          quantity: paper.quantity,
          uploadeddateandtime: paper.Buyedtime,
          usedpersent: paper.usedpersent,
          buyerid:paper.buyerid,
          parentproductid:paper.parentproductid,
          lat: paper.lat,
          lon: paper.lon,
          adress: paper.Adress,
        ))));
      }
        Snakebar(NavigationService.navigatorKey.currentContext,"Can't find order");
      }
      else if(snapshot.data()==null){
        Snakebar(NavigationService.navigatorKey.currentContext,"Can't find order");
      }
  }


  Future ScanScraperpaper(String id,BuildContext context)async{
    print("indb");
    print(id);

    String uid= await FirebaseAuth.instance.currentUser!.uid;

    final paper=await FirebaseFirestore.instance.collection("user").doc(uid).collection("scraporder").doc(id);
    final snapshot = await paper.get();
    if(snapshot.data()!=null){
      if(snapshot.data()!.isNotEmpty){
        final paper=Product.fromJson(snapshot.data()!);
        Navigator.push(
            context,( MaterialPageRoute(builder: (context)=>Scraperorderdetails(
          value: id,
          url1: paper.url1,
          url2: paper.url2,
          productid: paper.productid,
          uploaderid: paper.uploaderid,
          quantity: paper.quantity,
          uploadeddateandtime: paper.uploadeddateandtime,
          usedpersent: paper.usedpersent,
          lat: paper.lat,
          lon: paper.lon,
          adress: paper.Adress,
        ))));
      }
      Snakebar(NavigationService.navigatorKey.currentContext,"Can't find order");
    }
    else if(snapshot.data()==null){
      Snakebar(NavigationService.navigatorKey.currentContext,"Can't find order");
    }
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
  Future WritePaperData(quantity,usedpersent,url1,url2,latitude,longitude)async{
    String id=DateTime.now().millisecondsSinceEpoch.toString();
    String Adress=await Getlocation().GetAddressFromLatLong(latitude, longitude);
     var uid=FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection("paperdata").doc(id).set({
      "productid": id,
      "uploaderid":uid,
      "url1":url1,
      "url2":url2,
      "quantity":quantity,
      "usedpersent":usedpersent,
      "uploadeddateandtime":DateTime.now(),
      "lat":latitude,
      "lon":longitude,
      "Adress":Adress,

    }).then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"added"));

  }
  
  
  Future AfterScrapaccept(String ulid,String id)async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("user").doc(ulid).collection("inHand").doc(id).delete();
    await FirebaseFirestore.instance.collection("user").doc(ulid).collection("scrapaccept").doc(id).delete();
    await FirebaseFirestore.instance.collection("user").doc(uid).collection("scraporder").doc(id).delete();
  }
  

  Future UpdateuserData(quality,size,uid)async{
    await FirebaseFirestore.instance.collection("user").doc(uid).update({
      "user":uid,
      "quality":quality,
      "size":size,
      "time":DateTime.now(),

    }).then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"added"));

  }

  Future CancelUserorder(String odrid,String selleruid,String parentid,int quantity)async{
    final paperdata= FirebaseFirestore.instance.collection("paperdata").doc(parentid);
    final snapshot =await paperdata.get();
    if(snapshot.exists){
      final paper=Product.fromJson(snapshot.data()!);
      prevquantity=paper.quantity;}


    await FirebaseFirestore.instance.collection("paperdata").doc(parentid).update({
      "quantity":prevquantity+quantity,
    });
    await FirebaseFirestore.instance.collection("user").doc(uid).collection("buyedproduct").doc(odrid).delete();
    await FirebaseFirestore.instance.collection("user").doc(selleruid).collection("orderedproduct").doc(odrid).delete().then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"Order cancelled"));


  }

  Future Buypaper(String id,int quantity,String sellerid)async{
    final paperdata= FirebaseFirestore.instance.collection("paperdata").doc(id);
    final snapshot =await paperdata.get();
    if(snapshot.exists){
      final paper=Product.fromJson(snapshot.data()!);
      prevquantity=paper.quantity;






    String buyedid=DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection("user").doc(uid).collection("buyedproduct").doc(buyedid).set({
      "productid": buyedid,
      "parentproductid":id,
      "sellerid":sellerid,
      "url1":paper.url1,
      "url2":paper.url2,
      "lat":paper.lat,
      "lon":paper.lon,
      "Adress":paper.Adress,
      "quantity":quantity,
      "usedpersent":paper.usedpersent,
      "Buyedtime":DateTime.now(),




    });


    await FirebaseFirestore.instance.collection("user").doc(sellerid).collection("orderedproduct").doc(buyedid).set({
      "productid": buyedid,
      "parentproductid":id,
      "url1":paper.url1,
      "url2":paper.url2,
      "lat":paper.lat,
      "lon":paper.lon,
      "Adress":paper.Adress,
      "quantity":quantity,
      "usedpersent":paper.usedpersent,
      "buyerid":uid,
      "Buyedtime":DateTime.now(),
    });


    await FirebaseFirestore.instance.collection("paperdata").doc(id).update({
      "quantity":prevquantity-quantity,

    });

}
  }
  //Scraperrequest

  Future Scraprequestscraper(String url1,String url2,int quantity,double latitude,double longitude,String proid,String ulid) async{
    var uid=FirebaseAuth.instance.currentUser?.uid;
    String Adress=await Getlocation().GetAddressFromLatLong(latitude, longitude);
    await FirebaseFirestore.instance.collection("user").doc(uid).collection("scraporder").doc(proid).set(
        {
          "productid":proid,
          "uploaderid":ulid,
          "url1":url1,
          "url2":url2,
          "quantity":quantity,
          "usedpersent":100,
          "uploadeddateandtime":DateTime.now(),
          "lat":latitude,
          "lon":longitude,
          "Adress":Adress,
        });
    await FirebaseFirestore.instance.collection("user").doc(ulid).collection("scrapaccept").doc(proid).set(
        {
          "productid":proid,
          "uploaderid":uid,
          "url1":url1,
          "url2":url2,
          "quantity":quantity,
          "usedpersent":100,
          "uploadeddateandtime":DateTime.now(),
          "lat":latitude,
          "lon":longitude,
          "Adress":Adress,
        });

    await FirebaseFirestore.instance.collection("paperdata").doc(proid).delete();
  }


  //Screaprequest

  Future Scraprequestuser(String url1,String url2,int quantity,double latitude,double longitude,String proid) async {
    String id=DateTime.now().millisecondsSinceEpoch.toString();
    String Adress=await Getlocation().GetAddressFromLatLong(latitude, longitude);
    var uid=FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection("paperdata").doc(proid).set({
      "productid": proid,
      "uploaderid":uid,
      "url1":url1,
      "url2":url2,
      "quantity":quantity,
      "usedpersent":100,
      "uploadeddateandtime":DateTime.now(),
      "lat":latitude,
      "lon":longitude,
      "Adress":Adress,

    });
   await FirebaseFirestore.instance.collection("user").doc(uid).collection("inHand").doc(proid).update({
     "usedpersent":100,
   }).then((value) => Snakebar(NavigationService.navigatorKey.currentContext,"Scraprequest made"));
  }
  //Handoverfunction

  Future Handover(String buyerid,String pid, String oid,String url1,String url2,double lat,double lon,String adress,int quantity,int usedpersent)async{
    String uid=FirebaseAuth.instance.currentUser!.uid;
    String buyedid=DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection("user").doc(buyerid).collection("inHand").doc(buyedid).set({
      "productid": buyedid,
      "parentproductid":pid,
      "sellerid":uid,
      "url1":url1,
      "url2":url2,
      "lat":lat,
      "lon":lon,
      "Adress":adress,
      "quantity":quantity,
      "usedpersent":usedpersent,
      "Buyedtime":DateTime.now(),

    });

    await FirebaseFirestore.instance.collection("user").doc(uid).collection("orderhistory").doc(buyedid).set({
      "productid": buyedid,
      "parentproductid":pid,
      "url1":url1,
      "url2":url2,
      "lat":lat,
      "lon":lon,
      "Adress":adress,
      "quantity":quantity,
      "usedpersent":usedpersent,
      "buyerid":buyerid,
      "Buyedtime":DateTime.now(),

    });
    await FirebaseFirestore.instance.collection("user").doc(uid).collection("orderedproduct").doc(oid).delete();
    await FirebaseFirestore.instance.collection("user").doc(buyerid).collection("buyedproduct").doc(oid).delete();
    Snakebar(NavigationService.navigatorKey.currentContext,"HandOver Sucess");
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
  // FirebaseFirestore.instance.collection('paperdata').where("uploderid",isEqualTo:uid)
  //     .snapshots()
  //     .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());


  // STREAMS //

  Stream <List<Product>> ReadSellerpaper() {

      var uid = FirebaseAuth.instance.currentUser?.uid;
      String? uuid=uid;
      print(uuid);
    return FirebaseFirestore.instance.collection('paperdata').where("uploaderid",isEqualTo:uuid).orderBy("uploadeddateandtime",descending: true).
        snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }

  Stream <List<userOrder>> ReadInhandpaper() {

    final uid=FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('user').doc(uid).collection("inHand").snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>userOrder.fromJson(doc.data())).toList());
  }



  Stream <List<Product>> ReadUserpaper() {
    return FirebaseFirestore.instance.collection('paperdata').where("usedpersent",isNotEqualTo: 100).orderBy("usedpersent").
    snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }


  Stream <List<Product>> ReadScraperpaper() {
    return FirebaseFirestore.instance.collection('paperdata').where("usedpersent",isEqualTo: 100).orderBy("quantity",descending: true).
    snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }



  Stream <List<Product>> ReadScraperorderpaper() {

    final uid=FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('user').doc(uid).collection("scraporder").snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }
  Stream <List<Product>> Readuserscrapacceptpaper() {

    final uid=FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('user').doc(uid).collection("scrapaccept").snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());
  }




  Stream <List<userOrder>> ReadUserOrderpaper(){
    final uid=FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('user').doc(uid).collection("buyedproduct").snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>userOrder.fromJson(doc.data())).toList());

  }
  Stream <List<SellerOrder>> ReadSellerOrderpaper(){
    final uid=FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('user').doc(uid).collection("orderedproduct").snapshots()
        .map((snapshots) =>snapshots.docs.map((doc) =>SellerOrder.fromJson(doc.data())).toList());

  }

  Stream <List<Product>> ReadAppdata()=>
      FirebaseFirestore.instance.collection('paperdata')
          .snapshots()
          .map((snapshots) =>snapshots.docs.map((doc) =>Product.fromJson(doc.data())).toList());


// TIME CONVERTER//


  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }

  Snakebar(BuildContext? context,String message){
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context!)
        .showSnackBar(snackbar);
  }
}
import 'package:charta/screens/adminpage.dart';
import 'package:charta/screens/scraperpage.dart';
import 'package:charta/screens/sellerpage.dart';
import 'package:charta/screens/userpage.dart';
import 'package:flutter/material.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/roles.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override

  String uid=  FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;


  final rolestatus = Database().UserRole();




  Widget build(BuildContext context) {

    // if(rolestatus=="user"){
    //   return Userpage();
    // }
    // else if(rolestatus=="seller"){
    //   return Sellerpage();
    // }
    // else if(rolestatus=="scraper"){
    //   return Scrapperpage();
    // }else if(rolestatus=="admin"){
    //   return Adminpage();
    // }else{
      return Scaffold(
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("user").doc(uid).snapshots(),
          builder:(context,AsyncSnapshot<DocumentSnapshot>snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
            { return const Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasData){


              return switchrollpage(snapshot);
            }
            else{
              return const Center(child: Text("Something went wrong"));
            }
          },


        ),
        // body: Center(child: Column(
        //     children:[ SizedBox(height: 20),CircleAvatar(
        //       radius: 50,
        //       backgroundImage:NetworkImage(user.photoURL!) ,
        //     ),SizedBox(height: 8),
        //       Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
        //       SizedBox(height: 8),
        //       Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
        //       Text("no user data fount"),
        //       SizedBox(height: 20),
        //       TextButton(onPressed: (){
        //         final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
        //         provider.logout();
        //       }, child: Text("Logout"))
        //     ]
        // ),),

      );

  }

  switchrollpage(AsyncSnapshot<DocumentSnapshot> snapshot) {
if(snapshot.data!['role']=='admin'){
  return Adminpage();
}
else if(snapshot.data!['role']=='seller'){
  return Sellerpage();
}
else if(snapshot.data!['role']=='scraper'){
  return Scrapperpage();
}
else if(snapshot.data!['role']=='user'){
  return Userpage();
}
else{
  return Userpage();
}



  }
}



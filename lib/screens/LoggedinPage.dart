import 'package:charta/functions/Signin.dart';
import 'package:charta/screens/Welcomepage.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/functions/roles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class LoggedinPage extends StatefulWidget {
  const LoggedinPage({Key? key}) : super(key: key);

  @override
  _LoggedinPageState createState() => _LoggedinPageState();
}


class _LoggedinPageState extends State<LoggedinPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final uid=user.uid;




    if (Newusercheck()==true && Newrollcheck()==true){
      return const Roleselectpage();
    }else{
      return const Welcomepage();
      // return Scaffold(
      //     body: Center(child: Column(
      //         children:[ SizedBox(height: 20),CircleAvatar(
      //           radius: 50,
      //           backgroundImage:NetworkImage(user.photoURL!) ,
      //         ),SizedBox(height: 8),
      //           Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
      //           SizedBox(height: 8),
      //           Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
      //           Text("no user data fount"),
      //           SizedBox(height: 20),
      //           TextButton(onPressed: (){
      //             final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
      //             provider.logout();
      //           }, child: Text("Logout"))
      //         ]
      //     ),),
      //
      //   );
    }
    // else { return Scaffold(
    //     body: Center(child: Column(
    //         children:[ SizedBox(height: 20),CircleAvatar(
    //           radius: 50,
    //           backgroundImage:NetworkImage(user.photoURL!) ,
    //         ),SizedBox(height: 8),
    //           Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
    //           SizedBox(height: 8),
    //           Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
    //           SizedBox(height: 20),
    //           Text("no user data fount"),
    //           TextButton(onPressed: (){
    //             final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
    //             provider.logout();
    //           }, child: Text("Logout"))
    //         ]
    //     ),),
    //
    //   );
    // }




  }
}

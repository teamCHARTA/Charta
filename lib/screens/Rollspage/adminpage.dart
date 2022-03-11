import 'package:charta/functions/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Adminpage extends StatefulWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  _AdminpageState createState() => _AdminpageState();
}
final user = FirebaseAuth.instance.currentUser!;
class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),actions: [TextButton(onPressed: (){
        final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
        provider.logout();
      }, child:Text("Logout",style: TextStyle(color: Colors.white),),),],),
      body:Column(
      children: [
        Center(child: Column(
            children:[ SizedBox(height: 20),CircleAvatar(
              radius: 50,
              backgroundImage:NetworkImage(user.photoURL!) ,
            ),SizedBox(height: 8),
              Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
              SizedBox(height: 8),
              Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
              SizedBox(height: 20),
              TextButton(onPressed: (){
                final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
                provider.logout();
              }, child: Text("Logout"))
            ]
        ),),
        Center(child: Text("Adminpage"),),
        TextButton(onPressed: (){
          final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
          provider.logout();
        }, child: Text("Logout"))
      ],
    ),);
  }
}

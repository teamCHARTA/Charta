import 'package:charta/functions/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signin"),),
      body: Column(
        children: [TextButton(onPressed: ()async{
          final  provider =  Provider.of<GoogleSigninProvider>(context,listen: false);

          await provider. googleLogin().then((value) => Navigator.pop(context));
          

                }, child:Text("Signin With Gooogle"))],
      )


    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';
class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Column(
      children: [
        Center(child: Text("Userpage"),),
        TextButton(onPressed: (){
          final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
          provider.logout();
        }, child: Text("Logout"))
      ],
    ),);
  }
}

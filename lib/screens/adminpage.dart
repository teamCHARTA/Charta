import 'package:charta/functions/Signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Adminpage extends StatefulWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  _AdminpageState createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Column(
      children: [
        Center(child: Text("Adminpage"),),
        TextButton(onPressed: (){
          final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
          provider.logout();
        }, child: Text("Logout"))
      ],
    ),);
  }
}

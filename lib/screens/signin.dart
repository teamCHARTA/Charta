import 'package:charta/functions/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromRGBO(202, 228, 250,1),
      appBar: AppBar(title: Text("Signin"),),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(onPressed: ()async{
              final  provider =  Provider.of<GoogleSigninProvider>(context,listen: false);

              await provider. googleLogin();


                    }, label:Text("Signin With Gooogle"), icon:FaIcon(FontAwesomeIcons.google)),
            ) ,
                  ],
        ),
      )


    );
  }
}

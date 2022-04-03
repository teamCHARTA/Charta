import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/colorfunction.dart';
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
        backgroundColor: someColor().generateMaterialColor(Palette.secondary),
        appBar: AppBar(
          title: Text("Signin"),
        ),
        body: Center(
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width ,

                  decoration: BoxDecoration(
                    image:DecorationImage(image:AssetImage("assets/img.jpg"),fit:BoxFit.contain),
                    borderRadius: BorderRadius.circular(10),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  child: ElevatedButton.icon(
                      onPressed: () async {
                        final provider = Provider.of<GoogleSigninProvider>(
                            context,
                            listen: false);

                        await provider.googleLogin();
                      },
                      label: Text("Signin With Gooogle"),
                      icon: FaIcon(FontAwesomeIcons.google)),
                ),
              ),
            ],
          ),
        ));
  }
}

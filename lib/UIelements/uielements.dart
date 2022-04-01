import 'package:charta/screens/Rollspage/userpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../functions/Signin.dart';
import '../functions/colorfunction.dart';
import 'package:charta/UIelements/routs.dart';
import 'Navigationprovidor.dart';
class NavigationDrawerWidget extends StatelessWidget {
  static final padding = EdgeInsets.symmetric(horizontal: 20);
  final user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) => Drawer(
    child: Container(
      color:someColor().generateMaterialColor(Palette.primary),
      child: ListView(
        children: <Widget>[
          buildHeader(
            context,
            urlImage: user.photoURL!,
            name: user.displayName!,
            email: user.email!,
          ),
          Container(
            padding: padding,
            child: Column(
              children: [
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  onclicked:(){ Navigator.pushReplacementNamed(context, pageRoutes.userpage);} ,
                  text: 'Home',
                  icon: FontAwesomeIcons.house,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  onclicked:(){ Navigator.pushReplacementNamed(context, pageRoutes.userorder);} ,
                  text: 'Myorders',
                  icon: FontAwesomeIcons.firstOrder,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  onclicked:(){ Navigator.pushReplacementNamed(context, pageRoutes.inhand);} ,

                  text: 'Inhand',
                  icon: FontAwesomeIcons.boxOpen,
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  context,
                  onclicked:(){ Navigator.pushReplacementNamed(context, pageRoutes.scraprequest);} ,
                  text: 'Scrape request',
                  icon: FontAwesomeIcons.recycle,
                ),
                const SizedBox(height: 24),
                Divider(color: Colors.white70),
                const SizedBox(height: 24),
                buildMenuItem(
                  context,
                  onclicked:(){
                    Navigator.of(context).pop;
                    final provider =
                    Provider.of<GoogleSigninProvider>(context, listen: false);
                    provider.logout();
                  },
                  text: 'Logout',
                  icon: FontAwesomeIcons.bed,
                ),
                // const SizedBox(height: 16),
                // buildMenuItem(
                //   context,
                //
                //   text: 'Notifications',
                //   icon: FontAwesomeIcons.font,
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildMenuItem(
      BuildContext context, {
        required VoidCallback onclicked,
        required String text,
        required IconData icon,
      }) {


    return Material(
      color: Colors.transparent,
      child: ListTile(
        selectedTileColor: Colors.white24,
        leading: FaIcon(icon, color:someColor().generateMaterialColor(Palette.secondary)),
        title: Text(text, style: TextStyle(color:someColor().generateMaterialColor(Palette.secondary), fontSize: 16)),
        onTap: onclicked,

      ),
    );
  }



  Widget buildHeader(
      BuildContext context, {
        required String urlImage,
        required String name,
        required String email,
      }) =>
      Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                //Spacer(),
                // CircleAvatar(
                //   radius: 24,
                //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
                // )
              ],
            ),
          ),
        ),
      );
}



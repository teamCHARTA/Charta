import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../functions/Signin.dart';
import '../functions/colorfunction.dart';
import 'package:charta/UIelements/routs.dart';

bool top = true;

class NavigationDrawerWidget extends StatefulWidget {
  static final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final user = FirebaseAuth.instance.currentUser!;
  String usemail = email(FirebaseAuth.instance.currentUser!.email);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Container(
          color: someColor().generateMaterialColor(Palette.primary),
          child: ListView(
            children: <Widget>[
              buildHeader(
                context,
                urlImage: user.photoURL!,
                name: user.displayName!,
                email: user.email!,
              ),
              Container(
                padding: NavigationDrawerWidget.padding,
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      onclicked: () {
                        Navigator.pushReplacementNamed(
                            context, pageRoutes.userpage);
                      },
                      text: 'Home',
                      icon: FontAwesomeIcons.house,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      onclicked: () {
                        Navigator.pushReplacementNamed(
                            context, pageRoutes.userorder);
                      },
                      text: 'Myorders',
                      icon: FontAwesomeIcons.firstOrder,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      onclicked: () {
                        Navigator.pushReplacementNamed(
                            context, pageRoutes.inhand);
                      },
                      text: 'Inhand',
                      icon: FontAwesomeIcons.boxOpen,
                    ),
                    const SizedBox(height: 16),
                    buildMenuItem(
                      context,
                      onclicked: () {
                        Navigator.pushReplacementNamed(
                            context, pageRoutes.scraprequest);
                      },
                      text: 'Scrape request',
                      icon: FontAwesomeIcons.recycle,
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.white70),
                    const SizedBox(height: 24),
                    buildMenuItem(
                      context,
                      onclicked: () async {
                        final provider = Provider.of<GoogleSigninProvider>(
                            context,
                            listen: false);
                        await provider.logout();
                        await SystemChannels.platform
                            .invokeMethod<void>('SystemNavigator.pop');
                      },
                      text: 'Logout',
                      icon: FontAwesomeIcons.arrowRightFromBracket,
                    ),
                    const SizedBox(height: 16),
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
        leading: FaIcon(icon,
            color: someColor().generateMaterialColor(Palette.secondary)),
        title: Text(text,
            style: TextStyle(
                color: someColor().generateMaterialColor(Palette.secondary),
                fontSize: 16)),
        onTap: onclicked,
      ),
    );
  }

  Widget buildHeader(
    BuildContext context, {
    required String urlImage,
    required String name,
    required String email,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          padding: NavigationDrawerWidget.padding
              .add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usemail,
                    overflow: TextOverflow.fade,
                    softWrap: false,
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
}

String email(String? email) {
  if (email!.length > 23) {
    email = email.substring(0, 23) + "...";
    return email;
  } else {
    return email;
  }
}

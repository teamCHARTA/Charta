import 'package:charta/UIelements/uielements.dart';
import 'package:flutter/material.dart';


class HeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: NavigationDrawerWidget(),
    appBar: AppBar(
      backgroundColor: Colors.pink,
      title: Text("name"),
      centerTitle: true,
    ),
    body: Image.network(
      "urlImage",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}
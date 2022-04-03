import 'package:charta/functions/Signin.dart';
import 'package:charta/screens/Welcomepage.dart';
import 'package:charta/screens/Rollspage/roles.dart';
import 'package:flutter/material.dart';

class LoggedinPage extends StatefulWidget {
  const LoggedinPage({Key? key}) : super(key: key);

  @override
  _LoggedinPageState createState() => _LoggedinPageState();
}

class _LoggedinPageState extends State<LoggedinPage> {
  @override
  Widget build(BuildContext context) {
    if (Newusercheck() == true && Newrollcheck() == true) {
      return const Roleselectpage();
    } else {
      return const Welcomepage();
    }
  }
}

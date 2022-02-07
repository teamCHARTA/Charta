import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Roles(BuildContext context){
  if (Newusercheck()==true){
    return Navigator.push(context, new MaterialPageRoute(builder: (context)=>const Roleselectpage()));
  }else{
    return const Text("olduser",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),);
  }

}

class Roleselectpage extends StatefulWidget {
  const Roleselectpage({Key? key}) : super(key: key);

  @override
  _RoleselectpageState createState() => _RoleselectpageState();
}

class _RoleselectpageState extends State<Roleselectpage> {
  @override
   String role="user";
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [Row(
          children: [
            Radio(
              value: "user",
              groupValue: role,
              activeColor: const Color(0xFF6200EE),
              onChanged:(value){
                setState(() {
                  role =value.toString();
                });
              },
            ),
            const SizedBox(height: 10),
            const Text("User")
          ],
        ),Row(
          children: [
            Radio(
              value: "seller",
              groupValue: role,
              activeColor: const Color(0xFF6200EE),
              onChanged:(value){
                setState(() {
                  role =value.toString();
                });
              },
            ),
            const SizedBox(height: 10),
            const Text("Seller")
          ],
        ),Row(
          children: [
            Radio(
              value: "scraper",
              groupValue: role,
              activeColor: const Color(0xFF6200EE),
              onChanged:(value){
                setState(() {
                  role =value.toString();
                });
              },
            ),
            const SizedBox(height: 10),
            const Text("Scraper")
          ],
        ),const SizedBox(height: 20),
        TextButton(onPressed: (){
          Newrollupdate(1);
          final uid =  FirebaseAuth.instance.currentUser?.uid;
          if(uid!=null){Database().Userdatawrite(uid, role);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
          }

        }, child: Text("Continue"), )],
      ) ,
    );
  }
}
// Column(
// children: <Widget>[
// for (int i = 1; i <= 5; i++)
// ListTile(
// title: Text(
// 'Radio $i',
// style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
// ),
// leading: Radio(
// value: i,
// groupValue: _value,
// activeColor: Color(0xFF6200EE),
// onChanged: i == 5 ? null : (int value) {
// setState(() {
// _value = value;
// });
// },
// ),
// ),
// ],
// )
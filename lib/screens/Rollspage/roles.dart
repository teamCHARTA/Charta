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
final uid =  FirebaseAuth.instance.currentUser?.uid;
String role="user";
class Roleselectpage extends StatefulWidget {
  const Roleselectpage({Key? key}) : super(key: key);

  @override
  _RoleselectpageState createState() => _RoleselectpageState();
}

class _RoleselectpageState extends State<Roleselectpage> {
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Select a Roll"),),
      resizeToAvoidBottomInset:false,
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
                if(uid!=null)
                {Database().Userdatawrite(role);}
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
                if(uid!=null)
                {Database().Userdatawrite(role);}
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

              if(uid!=null)
              {Database().Userdatawrite(role);}
              },
            ),
            const SizedBox(height: 10),
            const Text("Scraper")
          ],
        ),const SizedBox(height: 20),
        TextButton(onPressed: (){
          Newrollupdate(1);
          if( uid !=null)
          {Database().Userdatawrite(role);

          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
          }

        }, child: Text("Continue"), )],
      ) ,
    );
  }
}

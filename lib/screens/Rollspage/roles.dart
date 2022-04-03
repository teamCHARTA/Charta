import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../functions/colorfunction.dart';

Roles(BuildContext context) {
  if (Newusercheck() == true) {
    return Navigator.push(context,
        new MaterialPageRoute(builder: (context) => const Roleselectpage()));
  } else {
    return const Text(
      "olduser",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
  }
}

final uid = FirebaseAuth.instance.currentUser?.uid;
String role = "user";

class Roleselectpage extends StatefulWidget {
  const Roleselectpage({Key? key}) : super(key: key);

  @override
  _RoleselectpageState createState() => _RoleselectpageState();
}

class _RoleselectpageState extends State<Roleselectpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a Roll"),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: someColor().generateMaterialColor(Palette.container),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Radio(
                  value: "user",
                  groupValue: role,
                  activeColor:
                      someColor().generateMaterialColor(Palette.hardprimary),
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });
                    if (uid != null) {
                      Database().Userdatawrite(role);
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text("User")
              ],
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "User Role can only Buy papers.They can't make a Sell or make a ScrapRequest",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary)),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "seller",
                  groupValue: role,
                  activeColor:
                      someColor().generateMaterialColor(Palette.hardprimary),
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });
                    if (uid != null) {
                      Database().Userdatawrite(role);
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text("Seller")
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Seller Role can only Sell papers.They can't make a Buy or make a ScrapRequest",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary)),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "scraper",
                  groupValue: role,
                  activeColor:
                      someColor().generateMaterialColor(Palette.hardprimary),
                  onChanged: (value) {
                    setState(() {
                      role = value.toString();
                    });

                    if (uid != null) {
                      Database().Userdatawrite(role);
                    }
                  },
                ),
                const SizedBox(height: 10),
                const Text("Scraper")
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Scraper Role can only make ScrapRequest on 100% used paper.They can't make a Buy or make a Sell on this platform",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Rolls can be slected only once, Thats now! But CHARTA promote multiple Signin from Different Google Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary)),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Newrollupdate(1);
                  if (uid != null) {
                    Database().Userdatawrite(role);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  }
                },
                child: Text("Continue"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

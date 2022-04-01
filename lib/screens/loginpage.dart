import 'package:charta/gmapservices/gmapmainnew.dart';
import 'package:charta/qrscreens/createqr.dart';
import 'package:charta/qrscreens/scanqr.dart';
import 'package:charta/screens/signin.dart';
import 'package:flutter/material.dart';

import 'image_resizer.dart';
class logtosignin extends StatefulWidget {
  const logtosignin({Key? key}) : super(key: key);

  @override
  _logtosigninState createState() => _logtosigninState();
}

class _logtosigninState extends State<logtosignin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body:  Row(
        children: [
          Column(
              children:
              [
                TextButton(
                  onPressed: (){Navigator.push(context,  MaterialPageRoute(builder: (context)=>const Signin()));},
                  child:const  Text("Signin and logout"),),
                const SizedBox(height: 10,),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=>const CreateScreen(uniqCode: 'killer says hi',)//calling with uniqueCode
                      ));
                    },
                    child: const Text('Create QR')),
                const SizedBox(height: 10,),
                TextButton(onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     // builder: (context)=>ScanScreen()
                  // ));

                },
                    child: const Text('Scan QR')),
                const SizedBox(height: 10,),
                TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context)=>const Gmapmain()
                  ));

                },
                    child: const Text('map')),
                TextButton(
                  onPressed: (){Navigator.push(context,  MaterialPageRoute(builder: (context)=>const ImageResizer()));},
                  child:const  Text("imageresize"),),
                const SizedBox(height: 10,),
              ]),
        ],),
    );
  }
}

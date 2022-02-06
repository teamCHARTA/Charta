import 'package:charta_qr/screens/createqr.dart';
import 'package:charta_qr/screens/scanqr.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charta',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner and Creator'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctxt)=>const CreateScreen(uniqCode: 'killer says hi',)//calling with uniqueCode
                ));
              },
              child: const Text('Create QR')),
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctxt)=>ScanScreen()
                ));

          }, 
          child: const Text('Scan QR')),
        ],
      )),
    );
  }
}

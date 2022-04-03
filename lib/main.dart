import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/colorfunction.dart';
import 'package:charta/screens/Crudscreens/Scraporderpaper.dart';
import 'package:charta/screens/Crudscreens/inhandpage.dart';
import 'package:charta/screens/Crudscreens/orders.dart';
import 'package:charta/screens/Crudscreens/scraprequestuserpage.dart';
import 'package:charta/screens/Crudscreens/userorders.dart';
import 'package:charta/screens/Rollspage/scraperpage.dart';
import 'package:charta/screens/Rollspage/sellerpage.dart';
import 'package:charta/screens/Rollspage/userpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'UIelements/routs.dart';
import 'package:flutter/services.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

final ThemeData theme = ThemeData(
  primarySwatch: someColor().generateMaterialColor(Palette.primary),
  backgroundColor: someColor().generateMaterialColor(Palette.background),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSigninProvider(),
      child: MaterialApp(
          title: 'Charta',
          navigatorKey: NavigationService.navigatorKey,
          theme: theme,
          home: const MyHomePage(title: 'Charta'),
          routes: {
            pageRoutes.userpage: (context) => Userpage(),
            pageRoutes.sellerpage: (context) => Sellerpage(),
            pageRoutes.scaperpage: (context) => Scrapperpage(),
            pageRoutes.userorder: (context) => Usserorders(),
            pageRoutes.sellerorder: (context) => Sellerorders(),
            pageRoutes.scraperorder: (context) => ScraperOrder(),
            pageRoutes.inhand: (context) => Inhand(),
            pageRoutes.scraprequest: (context) => ScraprequestAccpetuser(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

import 'package:charta/screens/Crudscreens/userorders.dart';
import 'package:charta/screens/Rollspage/sellerpage.dart';
import 'package:charta/screens/Rollspage/userpage.dart';
import '../screens/Crudscreens/Scraporderpaper.dart';
import '../screens/Crudscreens/inhandpage.dart';
import '../screens/Crudscreens/orders.dart';
import '../screens/Crudscreens/scraprequestuserpage.dart';
import '../screens/Rollspage/scraperpage.dart';

class pageRoutes {
  static const String userpage = Userpage.routeName;
  static const String scaperpage = Scrapperpage.routeName;
  static const String sellerpage = Sellerpage.routeName;

  static const String userorder = Usserorders.routeName;
  static const String sellerorder = Sellerorders.routeName;
  static const String scraperorder = ScraperOrder.routeName;

  static const String inhand = Inhand.routeName;
  static const String scraprequest = ScraprequestAccpetuser.routeName;

  // static const String profile = profilePage.routeName;
  // static const String notification = notificationPage.routeName;
}

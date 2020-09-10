import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/ui/CartScreen.dart';
import 'package:clothiesApp/ui/MainScreen.dart';
import 'package:clothiesApp/ui/ProfileScreen.dart';
import 'package:clothiesApp/ui/SectionScreen.dart';
import 'package:clothiesApp/ui/favouriteScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

AppDatabase database;
void _handleNotificationReceived(OSNotification notification) {}
main() {
  database = AppDatabase();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Regular",
          primaryColorDark: Color(0xff5445F7),
          primaryColorLight: Color(0xff8E7AFD)),
      home: Main(0)));
}

class Main extends StatefulWidget {
  int indexB;
  Main(this.indexB);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String titleApp = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.init("b98d69f9-2dcc-46b3-915f-42ba3c294e7c", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(getTitle(widget.indexB),
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Theme.of(context).primaryColorDark,
        buttonBackgroundColor: Theme.of(context).primaryColorDark,
        height: 50,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 0,
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.home,
              size: 25,
              color: widget.indexB == 0 ? Colors.white : Colors.white),
          Icon(Icons.category,
              size: 25,
              color: widget.indexB == 1 ? Colors.white : Colors.white),
          Icon(Icons.shopping_cart,
              size: 25,
              color: widget.indexB == 2 ? Colors.white : Colors.white),
          Icon(Icons.favorite,
              size: 25,
              color: widget.indexB == 3 ? Colors.white : Colors.white),
          Icon(Icons.person_pin,
              size: 25,
              color: widget.indexB == 4 ? Colors.white : Colors.white),
          // Icon(Icons.more_horiz,
          //     size: 30, color: indexB == 4 ? Colors.white : Colors.grey),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            widget.indexB = index;
          });
        },
      ),
      body: selectedWidget(widget.indexB),
    );
  }

  Widget selectedWidget(int index) {
    if (index == 0) {
      return MainScreen();
    } else if (index == 1) {
      return SectionsScreen();
    } else if (index == 2) {
      return CartScreen();
    } else if (index == 3) {
      return FavouriteScreen();
    } else if (index == 4) {
      return ProfileScreen();
    }
    //  else if (index == 4) {
    //   return AboutUsScreen();
    // }
  }

  String getTitle(int index) {
    if (index == 0) {
      return "الرئيسية";
    } else if (index == 1) {
      return "الأقسام";
    } else if (index == 2) {
      return "المشتريات";
    } else if (index == 3) {
      return "المفضلة";
    } else if (index == 4) {
      return "الحساب";
    }
  }
}

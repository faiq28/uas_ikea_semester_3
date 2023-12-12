import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/prv/btnProvNavbar.dart';
import 'splash.dart';
import 'def.dart';
import 'package:uts_ikea_semester_3/pages/keranjang.dart';
import 'package:uts_ikea_semester_3/pages/wishlist/model/wishlistModel.dart';
// import 'package:uts_ikea_semester_3/splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistModel()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
            create: (context) => NavigationProvider(), child: MyApp()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark().copyWith(
      //   scaffoldBackgroundColor: const Color(0xff0E0E10),
      // ),
      home: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Splash();
          } else {
            return DefaultPage();
          }
        },
      ),
      // theme: ThemeData(
      //   textTheme: TextTheme(
      //     headline6: TextStyle(
      //       color: Colors.black,
      //         fontSize: 20.0,
      //         fontWeight: FontWeight.bold,
      //     )
      //   ),
      //   brightness: Brightness.light,
      // ),
    );
  }
}

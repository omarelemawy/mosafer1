
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'login/first_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        primaryColor: HexColor("#8F9F83"),
      ),
      debugShowCheckedModeBanner: false,
      home: FirstScreen()
    );
  }
}

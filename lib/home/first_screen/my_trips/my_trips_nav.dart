import 'package:flutter/material.dart';

import '../drawer.dart';

class MyTripsNav extends StatelessWidget {
  const MyTripsNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("رحلاتي",style: TextStyle(fontFamily: "beIN"),),
      ),

    );
  }
}

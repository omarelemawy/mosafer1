import 'package:flutter/material.dart';

import '../drawer.dart';

class NotifiNav extends StatelessWidget {
  const NotifiNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("الاشعارات",style: TextStyle(fontFamily: "beIN"),),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../drawer.dart';

class ChatNav extends StatelessWidget {
  const ChatNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("المحادثات",style: TextStyle(fontFamily: "beIN"),),
      ),
    );
  }
}

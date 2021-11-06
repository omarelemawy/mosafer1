import 'package:flutter/material.dart';

import '../drawer.dart';

class AddTrip extends StatelessWidget {
  const AddTrip({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("اضافة رحله",style: TextStyle(fontFamily: "beIN"),),
      ),
    );
  }
}

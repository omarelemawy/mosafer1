import 'package:flutter/material.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: TextButton(
        child: SVGIcons.barIcon,
        onPressed: () {
          HomeScreen.scaffKey.currentState.openDrawer();
        },
      ),
      centerTitle: true,
      title: Text(title,style: TextStyle(fontFamily: "beIN"),),
    );
  }
}

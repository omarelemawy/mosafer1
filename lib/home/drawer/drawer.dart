
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/profile_page.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            decoration:BoxDecoration(
              color:  MyTheme.mainAppBlueColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: HexColor("#FFFFFF"),
                  backgroundImage: AssetImage("assets/man.png"),
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              /*Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>EdartElmshare()));*/
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.home,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("الصفحه الرئيسية",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>ProfilePage()));
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.person,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("الصفحةالشخصية",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              /*Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>EdartElmshare()));*/
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.mail_outline,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("خدمة العملاء",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              /*Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>EdartElmshare()));*/
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.mail_outline,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("خدمات مجانية",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              /*Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>EdartElmshare()));*/
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.rule_outlined,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("الشروط والسياسة",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
          SizedBox(height: 30,),
          CacheHelper.getData(key: "token")==null?GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  (context)=>LoginScreen()),(c)=>false);
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.login,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("دخول التطبيق",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ):
          GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                  (context)=>LoginScreen()),(c)=>false);
              CacheHelper.removeData(key: "token");
            },
            child: Row(
              children: [
                SizedBox(width: 10,),
                Icon(Icons.logout,color:  MyTheme.mainAppBlueColor,),
                SizedBox(width: 10,),
                Text("خروج من التطبيق",style: TextStyle(color:  MyTheme.mainAppBlueColor,
                    fontWeight: FontWeight.bold,fontSize: 18),),
                Spacer(),
                Icon(Icons.chevron_right_rounded,color:  MyTheme.mainAppBlueColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



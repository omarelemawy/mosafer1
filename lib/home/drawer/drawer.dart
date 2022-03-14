
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/profile_page.dart';
import 'package:mosafer1/home/drawer/terms_and_policies.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'customer_service.dart';
import 'free_service.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          CacheHelper.getData(key: "token") == null ? Container(
            height: 200,
            decoration: BoxDecoration(
              color: MyTheme.mainAppColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: HexColor("#FFFFFF"),
                  backgroundImage: AssetImage("assets/man.png"),
                ),
              ],
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: MyTheme.mainAppColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("مسافر موثوق",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: double.infinity,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        ClipOval(
                          child: FadeInImage.assetNetwork(
                            height: 80,
                            width: 80,
                            placeholderCacheHeight: 80,
                            placeholderCacheWidth: 80,
                            placeholder: "assets/man.png",
                            image: CacheHelper.getData(key: "photo"),
                            imageErrorBuilder: (context,o,c)=>ClipOval(
                              child: Image.asset(
                                "assets/man.png",
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: 4.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: MyTheme.mainAppColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(CacheHelper.getData(key: "name"),style: TextStyle(color: Colors.white,fontSize: 18),)
              ],
            ),
          ),
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen())
                    , (route) => false);
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.home,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("الصفحه الرئيسية",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ),
          CacheHelper.getData(key: "token")!=null?
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>ProfilePage()));
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.person,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("الصفحةالشخصية",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ):SizedBox(),
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CustomerService()));
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.mail_outline,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("خدمة العملاء",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ),
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>TermsAndPolicies()));
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.rule_outlined,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("الشروط والسياسة",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ),
          CacheHelper.getData(key: "token")!=null?ListTile(
            leading: Icon(
              Icons.mail_outline,
              color: HexColor("#638462"),
            ),
            title: Text(
              "خدمات مجانية",
              style: TextStyle(
                  color: HexColor("#638462"),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            trailing: Icon(
              Icons.chevron_right_rounded,
              color: HexColor("#638462"),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FreeServiceScreen())),
          ):
          SizedBox(),
          CacheHelper.getData(key: "token")==null?
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                    (context)=>LoginScreen()),(c)=>false);
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.login,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("دخول التطبيق",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ):
          ListTile(
            title: GestureDetector(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
                    (context)=>LoginScreen()),(c)=>false);
                CacheHelper.removeData(key: "token");
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.logout,color: HexColor("#638462"),),
                  SizedBox(width: 10,),
                  Text("خروج من التطبيق",style: TextStyle(color: HexColor("#638462"),
                      fontWeight: FontWeight.bold,fontSize: 18),),
                  Spacer(),
                  Icon(Icons.chevron_right_rounded,color: HexColor("#638462"),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



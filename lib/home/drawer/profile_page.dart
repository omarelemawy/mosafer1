import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/CommentsEdit/CommentsEdit.dart';
import 'package:mosafer1/Complaint/ComplaintsPage.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/login/more_register_info.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'bloc/cubit_drawer.dart';
import 'edit_your_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => DrawerCubit()..getgetMosafrInform(),
        child: BlocConsumer<DrawerCubit,DrawerState>(builder:
            (BuildContext context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text("الصفحه الشخصية"),
                centerTitle: true,
              ),
              body: state is GetLoadingMosaferInformationStates?
              Center(child: CircularProgressIndicator()):
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
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
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                    Text(DrawerCubit.get(context).
                    mosafrInformationModel.data.name,style:
                    TextStyle(color: MyTheme.mainAppColor,
                        fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: HexColor("#A2B594"),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("عدد رحلاتك",style: TextStyle(color: Colors.black),),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Text("2")),
                          Text("نقاط سلبية",style: TextStyle(color: Colors.black)),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Text(DrawerCubit.get(context).
                              mosafrInformationModel.data.negativePointsCount.toString())),
                          Text("الصفقات",style: TextStyle(color: Colors.black)),
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration:BoxDecoration(
                                  color:Colors.white,
                                  shape: BoxShape.circle
                              ),
                              child: Text("0"))
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.insert_drive_file,color: MyTheme.mainAppColor,),
                          Text("تعديل بياناتك")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> EditYourData())),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.description,color: MyTheme.mainAppColor,),
                          SizedBox(width: 10,),
                          Text("بيانات التوثيق",style: TextStyle(color: MyTheme.mainAppColor),),
                          Spacer(),

                        ],
                      ),
                      trailing:  Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> MoreRegisterInfo())),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on,color: MyTheme.mainAppColor,),
                          Text("اشحن حسابك")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on,color: MyTheme.mainAppColor,),
                          Text("سحب رصيد")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: (){},
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.notifications_active,color: MyTheme.mainAppColor,),
                          Text("الشكاوي")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintesPage()));
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.monetization_on_outlined,color: MyTheme.mainAppColor,),
                          Text("العمليات المالية")
                        ],
                      ),
                      trailing: Padding(
                        child: Text("رصيدك : ٢٣٠ ريال"),
                        padding: const EdgeInsets.only(left: 15,right: 15),
                      ),
                      /*onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> MoneyTransactionPage())),*/
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.add_comment,color: MyTheme.mainAppColor,),
                          Text("تعديل التعليقات")
                        ],
                      ),
                      trailing: Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsEdit())),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, listener: (BuildContext context, state) {},
        )
    );
  }
}

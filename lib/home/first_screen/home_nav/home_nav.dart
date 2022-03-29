import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/MosaferProfile/MosaferProfilePage.dart';
import 'package:mosafer1/Travel/TravelDetails.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_cubit.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeNav extends StatefulWidget {
  BuildContext context1;
   HomeNav(this.context1);

  @override
  _HomeNavState createState() => _HomeNavState(context1);
}

class _HomeNavState extends State<HomeNav> {
  BuildContext context1;
  _HomeNavState(this.context1);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>HomeCubit()..getAllServices(),
      child: BlocConsumer<HomeCubit,HomeStates>(
        builder: (context,state){
          List<RequestServices> allRequestsSe = HomeCubit.get(context).allRequestsSe;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: state is GetLoadingAllRequestServicesStates?
              Center(child: CircularProgressIndicator()):Padding(
                padding: const EdgeInsets.only(bottom: 20.0,top: 10,right: 10,left: 10),
                child: allRequestsSe.isNotEmpty?
                  ListView.separated(itemBuilder: (context,index)=>
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: HexColor("#90AC7A")),),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        GestureDetector(
                                          onTap:  CacheHelper.getData(key: "token")==null?null:(){
                                            pushNewScreen(
                                              context,
                                              screen: MosaferProfilePage(allRequestsSe[index].user.id),
                                              withNavBar: false, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                            );

                                          },
                                          child: ClipOval(
                                            child: FadeInImage.assetNetwork(
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.fill,
                                              placeholderFit:BoxFit.fill,
                                              placeholderCacheHeight: 80,
                                              placeholderCacheWidth: 80,
                                              placeholder: "assets/man.png",
                                              image: allRequestsSe[index].user.photo,
                                              imageErrorBuilder: (context,o,c)=>ClipOval(
                                                child: Image.asset(
                                                  "assets/man.png",
                                                  fit: BoxFit.fill,
                                                  height: 80,
                                                  width: 80,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        allRequestsSe[index].user.isVerified=="1"?
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            child: Icon(Icons.check,color:Colors.white,size:12,),
                                            backgroundColor: Colors.green,
                                            radius: 7,
                                          ),
                                        ):SizedBox(),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: int.parse
                                        (allRequestsSe[index].user.rate).toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 15,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: HexColor("#F7FF03"),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("العميل :",
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ),),
                                          Expanded(
                                            child: Text(allRequestsSe[index].user==null?"":
                                            allRequestsSe[index].user.name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontFamily: "beIN",
                                                    fontWeight: FontWeight.bold,
                                                    color:HexColor("#707070")
                                                )),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,color: HexColor("#638462"),),
                                          Text(allRequestsSe[index].fromPlace==null?"":
                                          allRequestsSe[index].fromPlace,
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ),),
                                          Icon(Icons.chevron_right_rounded),
                                          Expanded(
                                            child: Text(allRequestsSe[index].toPlace==null?
                                            "":allRequestsSe[index].toPlace,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontFamily: "beIN",
                                                    fontWeight: FontWeight.bold,
                                                    color:HexColor("#707070")
                                                )),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("الوصف",
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ),),
                                          Icon(Icons.chevron_right_rounded),
                                          Expanded(
                                            child: Text(allRequestsSe[index].description==null?"":
                                            allRequestsSe[index].description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(fontFamily: "beIN",
                                                    fontWeight: FontWeight.bold,
                                                    color:HexColor("#707070")
                                                )),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.timer,size: 15,),
                                          SizedBox(width: 5,),
                                          Text("ينتهي الطلب خلال",
                                            style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color:HexColor("#707070")
                                            ),),
                                          Spacer(),
                                          allRequestsSe[index].maxDay==null?
                                          SizedBox():
                                          CountdownTimer(
                                            endTime: DateTime.parse(allRequestsSe[index].maxDay).millisecondsSinceEpoch,
                                            widgetBuilder: (_, CurrentRemainingTime time) {
                                              if (time == null) {
                                                return Text("طلب منتهي");
                                              }
                                              return  Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "يوم",
                                                        style: TextStyle(fontSize: 11),
                                                      ),
                                                      CircleAvatar(
                                                        child: FittedBox(
                                                          child: Text(
                                                            "${time.days}",
                                                            style: TextStyle(
                                                                fontSize: 12, color: Colors.white),
                                                          ),
                                                        ),
                                                        backgroundColor: MyTheme.mainAppColor
                                                            .withOpacity(0.6),
                                                        radius: 12,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "ساعة",
                                                        style: TextStyle(fontSize: 11),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 12,
                                                        child: FittedBox(
                                                          child: Text(
                                                            "${time.hours}",
                                                            style: TextStyle(
                                                                fontSize: 12, color: Colors.white),
                                                          ),
                                                        ),
                                                        backgroundColor: MyTheme.mainAppColor
                                                            .withOpacity(0.6),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "دقيقة",
                                                        style: TextStyle(fontSize: 11),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 12,
                                                        child: FittedBox(
                                                          child: Text(
                                                            "${time.min}",
                                                            style: TextStyle(
                                                                fontSize: 12, color: Colors.white),
                                                          ),
                                                        ),
                                                        backgroundColor: MyTheme.mainAppColor
                                                            .withOpacity(0.6),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "ثانية",
                                                        style: TextStyle(fontSize: 11),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 12,
                                                        child: FittedBox(
                                                          child: Text(
                                                            "${time.sec}",
                                                            style: TextStyle(
                                                                fontSize: 12, color: Colors.white),
                                                          ),
                                                        ),
                                                        backgroundColor: MyTheme.mainAppColor
                                                            .withOpacity(0.6),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                  color: HexColor("#A2B594"),
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10,),
                                  ElevatedButton(onPressed: (){
                                    pushNewScreen(
                                      context,
                                      screen: TravelDetailsPage(requestServices: allRequestsSe[index],),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                                      )
                                      , child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: MyTheme.mainAppColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Icon(Icons.chevron_left,
                                                color: Colors.white,),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(allRequestsSe[index].service.categorieName,style:
                                          TextStyle(fontFamily: "beIN",fontSize: 14,color: MyTheme.mainAppColor),),
                                        ],
                                      )),

                                  Spacer(),
                                  Image.asset("assets/icon_home.png"),

                                  SizedBox(width: 10,),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  itemCount: allRequestsSe.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20,);
                  },
                ):Center(child: Text("لا يوجد خدمات",style: TextStyle(fontSize: 20),)),
              ),
            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
}

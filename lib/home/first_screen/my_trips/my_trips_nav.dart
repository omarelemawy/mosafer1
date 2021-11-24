import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/drawer.dart';

import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/Constats.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'bloc/bloc_my_trips.dart';

class MyTripsNav extends StatelessWidget {
  BuildContext context1;
  final bool isFromMain;
  MyTripsNav(this.context1,{this.isFromMain = true});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyTripsBloc()..getMyTrip(),
      child: BlocConsumer<MyTripsBloc, MyTripsStates>(
        builder: (context, state) {
          List<Trips> allMyTrips = MyTripsBloc.get(context).allMyTrips;
          print("Trips : $allMyTrips");
          return CacheHelper.getData(key: "token") == null
              ? Scaffold(
                  body: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Go To Sing In First",
                            style: TextStyle(
                                color: HexColor("#A2B594"),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            color: HexColor("#A2B594"),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context1,
                                  MaterialPageRoute(
                                      builder: (context1) => LoginScreen()),
                                  (route) => false);
                            },
                            child: Text(
                              "Go",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  appBar: PreferredSize(
                    child: CustomAppBar(
                      title: "طلباتي",
                    ),
                    preferredSize: Size.fromHeight(60),
                  ),
                  body: state is GetLoadingAllMyRequestServicesStates
                      ? Center(child: CircularProgressIndicator())
                      : Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 20.0, top: 10, right: 10, left: 10),
                            child: ListView.separated(
                              itemBuilder: (context, index) => RequestItem(isFromMain: isFromMain,trips: allMyTrips[index]),
                              itemCount: allMyTrips.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                            ),
                          ),
                        ),
                );
        },
        listener: (context, state) {},
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  bool isFromMain;
  Trips trips;
  RequestItem({this.isFromMain = true,this.trips});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyTheme.mainAppBlueColor.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                Padding(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: ClipRRect(
                              child: FadeInImage.assetNetwork(
                                placeholder: placeholder2,
                                fit: BoxFit.cover,
                                image:
                                'https://www.iihs.org/api/ratings/model-year-images/3112/636/',
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 120,
                            height: 40,
                            child: FittedBox(
                              child: Text(
                                "توصيل",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 3),
                            decoration: BoxDecoration(
                                color: MyTheme.mainAppBlueColor,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: MyTheme.mainAppBlueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(trips.fromPlace),
                              Text("  >>  "),
                              Text(trips.toPlace),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.watch_later,
                                size: 20,
                                color: MyTheme.mainAppBlueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("ينتهي الطلب خلال"),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "يوم",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  CircleAvatar(
                                    child: FittedBox(
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                    MyTheme.mainAppBlueColor.withOpacity(0.6),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "ساعة",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  CircleAvatar(
                                    child: FittedBox(
                                      child: Text(
                                        "5",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                    MyTheme.mainAppBlueColor.withOpacity(0.6),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "دقيقة",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  CircleAvatar(
                                    child: FittedBox(
                                      child: Text(
                                        "40",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                    MyTheme.mainAppBlueColor.withOpacity(0.6),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "ثانية",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  CircleAvatar(
                                    child: FittedBox(
                                      child: Text(
                                        "60",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                    backgroundColor:
                                    MyTheme.mainAppBlueColor.withOpacity(0.6),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(9),
                ),
                IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){}, child: Text("تعديل",style: TextStyle(color: MyTheme.mainAppBlueColor),),style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                        ),),
                        Text("رقم الطلب :  232",style: TextStyle(color: Colors.white,fontSize: 16)),
                        IconButton(onPressed: (){}, icon: Icon(Icons.restore_from_trash,color: Colors.white,))
                      ],
                    ),
                    decoration: BoxDecoration(color: MyTheme.mainAppBlueColor),
                  ),
                )
              ],
            ),
          ),
          if(!isFromMain) ElevatedButton(onPressed: (){}, child: Text("تاكيد",style: TextStyle(color: Colors.white),),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyTheme.mainAppBlueColor),
              fixedSize: MaterialStateProperty.all(Size.fromWidth(120)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
          ),),
        ],
      ),
    );
  }
}

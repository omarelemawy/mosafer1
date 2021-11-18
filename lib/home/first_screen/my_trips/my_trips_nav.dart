import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'bloc/bloc_my_trips.dart';

class MyTripsNav extends StatelessWidget {
  BuildContext context1;
   MyTripsNav(this.context1);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>MyTripsBloc()..getMyTrip(),
      child: BlocConsumer<MyTripsBloc,MyTripsStates>(
        builder: (context,state){
          List<Trips> allMyTrips = MyTripsBloc.get(context).allMyTrips;
          return CacheHelper.getData(key: "token")==null?
          Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Go To Sing In First",style: TextStyle(color: HexColor("#A2B594"),
                      fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
                  MaterialButton(
                    color: HexColor("#A2B594"),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context1, MaterialPageRoute(builder: (context1)=>LoginScreen())
                          , (route) => false);
                    },
                    child: Text("Go",style: TextStyle(color: Colors.white
                    ),),
                  )
                ],
              ),
            ),
          ):
          Scaffold(
            body: state is GetLoadingAllMyRequestServicesStates?
            Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.only(bottom: 20.0,top: 10,right: 10,left: 10),
              child: ListView.separated(itemBuilder:
                  (context,index)=>
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: HexColor("#90AC7A")),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              /*Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:HexColor("#F5F4F4"),
                                        radius: 40,
                                        backgroundImage: NetworkImage(allMyTrips[index].active),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          child: Icon(Icons.check,color:Colors.white,size:12,),
                                          backgroundColor: Colors.green,
                                          radius: 7,
                                        ),
                                      ),
                                    ],
                                  ),
                                  RatingBar.builder(
                                    initialRating: 3,
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
                              ),*/
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Client :",
                                          style: TextStyle(fontFamily: "beIN",
                                              fontWeight: FontWeight.bold,
                                              color:HexColor("#707070")
                                          ),),
                                        Expanded(
                                          child: Text(allMyTrips[index].onProgress==null?"":
                                          allMyTrips[index].onProgress,
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
                                        Text(allMyTrips[index].fromPlace==null?"":
                                        allMyTrips[index].fromPlace,
                                          style: TextStyle(fontFamily: "beIN",
                                              fontWeight: FontWeight.bold,
                                              color:HexColor("#707070")
                                          ),),
                                        Icon(Icons.chevron_right_rounded),
                                        Expanded(
                                          child: Text(allMyTrips[index].toPlace==null?
                                          "":allMyTrips[index].toPlace,
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
                                        Text("Description",
                                          style: TextStyle(fontFamily: "beIN",
                                              fontWeight: FontWeight.bold,
                                              color:HexColor("#707070")
                                          ),),
                                        Icon(Icons.chevron_right_rounded),
                                        Expanded(
                                          child: Text(allMyTrips[index].description==null?"":
                                          allMyTrips[index].description,
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
                                        Text("Order Expires In",
                                          style: TextStyle(fontFamily: "beIN",
                                              fontWeight: FontWeight.bold,
                                              color:HexColor("#707070")
                                          ),),
                                        Icon(Icons.chevron_right_rounded),
                                        Text(allMyTrips[index].description==null?"":
                                        allMyTrips[index].description, style: TextStyle(fontFamily: "beIN",
                                            fontWeight: FontWeight.bold,
                                            color:HexColor("#707070")
                                        ))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        /*Stack(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Image.asset("assets/icon_home.png"),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 6) ,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(allMyTrips[index].toPlace,style:
                                        TextStyle(fontFamily: "beIN",fontSize: 14),),
                                        Icon(Icons.chevron_right),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                ],
                              ),
                            ),
                          ],
                        )*/
                      ],
                    ),
                  ),
                itemCount: allMyTrips.length,
                separatorBuilder: (BuildContext context, int index) {

                  return SizedBox(height: 20,);
                },
              ),
            ),
          );
        },
        listener: (context,state){
        },
      ),
    );
  }
}

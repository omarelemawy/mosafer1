import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/first_screen/my_trips/bloc/bloc_my_trips.dart';
import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/Dialogs/SimpleIconDialog.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class MyTripFromChatRoom extends StatefulWidget {
  final int chatRoomId;
  const MyTripFromChatRoom({Key key,this.chatRoomId}) : super(key: key);

  @override
  _MyTripFromChatRoomState createState() => _MyTripFromChatRoomState();
}

class _MyTripFromChatRoomState extends State<MyTripFromChatRoom> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>MyTripsBloc()..getMyTrip(),
      child: BlocConsumer<MyTripsBloc,MyTripsStates>(
        builder: (context,state){
          List<Trips> allMyTrips = MyTripsBloc.get(context).allMyTrips;
          return
          Scaffold(
            floatingActionButton: FloatingActionButton.extended(onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
            },
                label: Row(children: [
                Text("أضافة رحله",style: TextStyle(color: Colors.white),),
                Icon(Icons.add,color: Colors.white,)
              ],
            )),
            appBar: AppBar(
              title: Text("رحلاتي"),
            ),
            body: state is GetLoadingAllMyRequestServicesStates?
            Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.only(bottom: 20.0,top: 10,right: 10,left: 10),
              child:allMyTrips.isEmpty?
              Center(
                child: Text("لا يوجد لديك رحلات",style:
                TextStyle(color: MyTheme.mainAppColor,fontSize: 20),),
              ):
              ListView.separated(itemBuilder:
                  (context,index)=>
                  Column(
                    children: [
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
                                            Text("الوصف",
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
                                            Text("سينتهي في",
                                              style: TextStyle(fontFamily: "beIN",
                                                  fontWeight: FontWeight.bold,
                                                  color:HexColor("#707070")
                                              ),),
                                            Icon(Icons.chevron_right_rounded),
                                            Text(allMyTrips[index].endDate==null?"":
                                            allMyTrips[index].endDate, style: TextStyle(fontFamily: "beIN",
                                                fontWeight: FontWeight.bold,
                                                color:HexColor("#707070")
                                            ))
                                          ],
                                        ),
                                        /*Row(
                                          children: [
                                            SizedBox(width: 12,),
                                            GestureDetector(
                                              onTap: (){
                                                pushNewScreen(
                                                  context,
                                                  screen: MoreInformMyTrip(trips: allMyTrips[index],),
                                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                decoration: BoxDecoration(
                                                    color: MyTheme.mainAppColor,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.chevron_left,color: Colors.white,),
                                                    Text(
                                                      "معلومات أكتر",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(onPressed: (){
                                              MyTripsBloc.get(context).deleteTrip(allMyTrips[index].id,context);
                                            }, icon:
                                            Icon(Icons.delete_forever_outlined,color: MyTheme.mainAppColor,)),
                                            SizedBox(width: 12,)
                                          ],
                                        )*/
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

                      ElevatedButton(
                        onPressed: () {
                           MyTripsBloc.get(context).
                          createNegotiationRequest(request_id: allMyTrips[index].id,chat_id: widget.chatRoomId).
                           then((value) {
                             print(value);
                             Utils().showMyDialog(SimpleIconDialog(title: "Hello",
                                 body: value,
                                 icon : Icon(Icons.credit_card)), context);
                           });

                        },
                        child: Text(
                          "تاكيد",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(MyTheme.mainAppColor),
                            fixedSize: MaterialStateProperty.all(Size.fromWidth(120)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)))),
                      ),
                    ],
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

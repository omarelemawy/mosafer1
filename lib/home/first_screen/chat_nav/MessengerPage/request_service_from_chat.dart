import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/ChatMessengerScreen.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Constats.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../my_trip_from_chat_room.dart';

class RequestServiceFromChatPage extends StatefulWidget {
  final RequestServices requestServices;
  final int chatRoomsid;
  const RequestServiceFromChatPage({Key key, this.requestServices,this.chatRoomsid}) : super(key: key);
  @override
  _TravelDetailsPageState createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<RequestServiceFromChatPage> {
  List<MapLatLng> polylinePoints;
  Size size;
  ChatData _chatData = ChatData();

  @override
  void initState() {
    getLocation().then((value) {
      polylinePoints = [
        MapLatLng(value[0].latitude, value[0].longitude),
        MapLatLng(value[1].latitude, value[1].longitude),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:  (context)=>ChatMessengerScreen
              (chatRoomId:widget.chatRoomsid,)), (route) => false);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          FutureBuilder<List<Location>>(
            future: getLocation(),
            builder:  (context,snap) {
              if(snap.hasData) {
                return SfMaps(
                  layers: [
                    MapTileLayer(
                      initialFocalLatLng: MapLatLng(snap.data[0].latitude, snap.data[0].longitude),
                      initialZoomLevel: 4,
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      sublayers: [
                        MapPolylineLayer(
                          polylines: Set.of([
                            MapPolyline(
                              points: polylinePoints,
                            )
                          ]),
                        ),
                      ],
                      initialMarkersCount: 2,
                      markerBuilder: (context, index) {
                        if (index == 0) {
                          return MapMarker(
                              iconColor: Colors.white,
                              iconStrokeColor: Colors.blue,
                              iconStrokeWidth: 2,
                              latitude: snap.data[0].latitude,
                              longitude: snap.data[0].longitude);
                        }
                        return MapMarker(
                            iconColor: Colors.white,
                            iconStrokeColor: Colors.blue,
                            iconStrokeWidth: 2,
                            latitude:
                            snap.data[1].latitude,
                            longitude:
                            snap.data[1].longitude);
                      },
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          ),

          Padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipOval(
                  child: FadeInImage.assetNetwork(
                    height: 80,
                    width: 80,
                    placeholderCacheHeight: 80,
                    placeholderCacheWidth: 80,
                    placeholder: "assets/man.png",
                    image: widget.requestServices.user.photo,
                    imageErrorBuilder: (context,o,c)=>ClipOval(
                      child: Image.asset(
                        "assets/man.png",
                        height: 80,
                        width: 80,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.requestServices.user.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: MyTheme.mainAppBlueColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
                /*Container(
                  child: Text(
                    "المسافة ٠٠٠ كيلو",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: MyTheme.mainAppColor,
                      borderRadius: BorderRadius.circular(20)),
                )*/
              ],
            ),
            padding: const EdgeInsets.all(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                child: ElevatedButton(onPressed: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyTripFromChatRoom(chatRoomId: widget.chatRoomsid,)));
                }, child: Text("تفاوض مع رحلة من رحلاتي"),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.mainAppColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),),
                padding: const EdgeInsets.all(15),
              ),
              SlidingUpPanel(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                minHeight: size.height * 0.3,
                maxHeight: size.height * 0.5,
                color: MyTheme.mainAppColor,
                header: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      height: 35,
                      width: size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: MyTheme.mainAppColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                panel: Container(
                    margin: const EdgeInsets.only(top: 30),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.requestServices.typeOfCar.isNotEmpty ?  Text("مطلوب سيارة ") : SizedBox(),
                              SizedBox(),
                              widget.requestServices.haveInsurance == "" ? Text("مطلوب تامين" + " : " + widget.requestServices.insuranceValue + "ر.س") : SizedBox(),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.requestServices.onlyWomen == "" ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                        MyTheme.mainAppBlueColor.withOpacity(0.4)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        child: SVGIcons.woman,
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                      ),
                                      Text(
                                        "مطلوب سيدة",
                                        style:
                                        TextStyle(color: MyTheme.mainAppBlueColor),
                                      )
                                    ],
                                  )
                                ],
                              ) : SizedBox(),
                              SizedBox(),
                              Container(
                                child: Text(
                                  "توصيل طعام",
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: MyTheme.mainAppColor),
                              ),
                            ],
                          ),
                          Text(widget.requestServices.description.isEmpty ? "لا يوجد تفاصيل" : widget.requestServices.description,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context,index)=> Container(
                                child: ClipRRect(
                                  child: FadeInImage.assetNetwork(placeholder: placeholder2,
                                    image: 'https://www.iihs.org/api/ratings/model-year-images/3112/636/',),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                width: 120,
                                margin: const EdgeInsets.all(8),
                              ),
                            ),
                            height: 120,
                            width: size.width,
                          )
                        ],
                      ),
                    )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Future<List<Location>> getLocation()async {
    List<Location> locations=[];
    List<Location> locations3 = await locationFromAddress("الرياض");
    List<Location> locations4 = await locationFromAddress("مكه");
    List<Location> locations1 = await locationFromAddress(widget.requestServices.fromPlace).onError((error, stackTrace) => null);
    List<Location> locations2 = await locationFromAddress(widget.requestServices.toPlace).onError((error, stackTrace) => null);

    locations.add(locations1==null?locations3[0]:locations1[0]);
    locations.add(locations2==null?locations4[0]:locations2[0]);
    return locations;
  }
}

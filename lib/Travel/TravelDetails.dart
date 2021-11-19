import 'package:flutter/material.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Constats.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class TravelDetailsPage extends StatefulWidget {
  final RequestServices requestServices;
  const TravelDetailsPage({Key key, this.requestServices}) : super(key: key);
  @override
  _TravelDetailsPageState createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
  List<MapLatLng> polylinePoints;
  Size size;
  ChatData _chatData = ChatData();

  @override
  void initState() {
    polylinePoints = [
      MapLatLng(24.7255553, 46.5423402),
      MapLatLng(25.2794268, 45.8516119),
    ];
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
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          SfMaps(
            layers: [
              MapTileLayer(
                initialFocalLatLng: MapLatLng(24.7255553, 46.5423402),
                initialZoomLevel: 8,
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
                        latitude: polylinePoints[index].latitude,
                        longitude: polylinePoints[index].longitude);
                  }
                  return MapMarker(
                      iconColor: Colors.white,
                      iconStrokeColor: Colors.blue,
                      iconStrokeWidth: 2,
                      latitude:
                          polylinePoints[polylinePoints.length - 1].latitude,
                      longitude:
                          polylinePoints[polylinePoints.length - 1].longitude);
                },
              ),
            ],
          ),
          Padding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      widget.requestServices.user.photo),
                  radius: 35,
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
                Container(
                  child: Text(
                    "المسافة ٠٠٠ كيلو",
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: MyTheme.mainAppColor,
                      borderRadius: BorderRadius.circular(20)),
                )
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
                  _chatData.getOrCreateChatRoom(1 , 1).then((value) {
                    print("Chat room : ${value}");
                  });

                }, child: Text("تفاوض"),style: ButtonStyle(
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
                                  child: FadeInImage.assetNetwork(placeholder: placeholder2, image: 'https://www.iihs.org/api/ratings/model-year-images/3112/636/',),
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
}

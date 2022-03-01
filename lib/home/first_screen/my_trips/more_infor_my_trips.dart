import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class MoreInformMyTrip extends StatelessWidget {
  Trips trips;
   MoreInformMyTrip({Key key,this.trips}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("معلومات الرحله"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on,color: HexColor("#638462"),),
                    Text(trips.fromPlace==null?"":
                    trips.fromPlace,
                      style: TextStyle(fontFamily: "beIN",
                          fontWeight: FontWeight.bold,
                          color:HexColor("#707070")
                      ),),
                    Icon(Icons.chevron_right_rounded),
                    Expanded(
                      child: Text(trips.toPlace==null?
                      "":trips.toPlace,
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
                    Text("الوصف :",
                      style: TextStyle(fontFamily: "beIN",
                          fontWeight: FontWeight.bold,
                          color:HexColor("#707070")
                      ),),
                    Icon(Icons.chevron_right_rounded),
                    Expanded(
                      child: Text(trips.description==null?"":
                      trips.description,
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
                    Text(trips.endDate==null?"":
                    trips.endDate, style: TextStyle(fontFamily: "beIN",
                        fontWeight: FontWeight.bold,
                        color:HexColor("#707070")
                    ))
                  ],
                ),
                /*Row(
                  children: [
                   */
                /* SizedBox(width: 12,),
                    GestureDetector(
                      onTap: (){

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
                    ),*//*
                    Spacer(),
                    IconButton(onPressed: (){}, icon:
                    Icon(Icons.delete_forever_outlined,color: MyTheme.mainAppColor,)),
                    SizedBox(width: 12,)
                  ],
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

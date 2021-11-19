import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';

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
          return Scaffold(
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
                  SizedBox(height: 30,),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor:HexColor("#F5F4F4"),
                        radius: 40,
                        backgroundImage: NetworkImage(""),
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
                    initialRating:double.parse(DrawerCubit.get(context).mosafrInformationModel.data.rate),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: HexColor("#9EA657"),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(DrawerCubit.get(context).mosafrInformationModel.data.name,style: TextStyle(color: HexColor("#5787A6"),
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.all(5),
                    color: HexColor("#A2B594"),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Number Of Trips",style: TextStyle(color: Colors.black),),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration:BoxDecoration(
                            color:Colors.white,
                            shape: BoxShape.circle
                          ),
                            child: Text("0")),
                        Text("Negative points",style: TextStyle(color: Colors.black)),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration:BoxDecoration(
                                color:Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Text("0")),
                        Text("Bargains",style: TextStyle(color: Colors.black)),
                        Container(
                            padding: EdgeInsets.all(10),
                            decoration:BoxDecoration(
                                color:Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Text("0")),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditYourData()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                             Icon(Icons.description,color: HexColor("#5787A6"),),
                             SizedBox(width: 10,),
                             Text("Edit your data",style: TextStyle(color: HexColor("#5787A6")),),
                             Spacer(),
                             Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.description,color: HexColor("#5787A6"),),
                          SizedBox(width: 10,),
                          Text("Authentication data",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/attach_money_black_24dp.png",errorBuilder: (context, error, stackTrace) => Container()),
                          SizedBox(width: 10,),
                          Text("Charge your account",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/Group 1343.png",errorBuilder: (context, error, stackTrace) => Container()),
                          SizedBox(width: 10,),
                          Text("Balance withdrawal",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/request_quote_black_24dp.png",errorBuilder: (context, error, stackTrace) => Container()),
                          SizedBox(width: 10,),
                          Text("Financial Operations",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/edit_note_black_24dp.png",errorBuilder: (context, error, stackTrace) => Container(),),
                          SizedBox(width: 10,),
                          Text("Edit comments",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(Icons.notifications_paused_outlined,color: HexColor("#5787A6"),),
                          SizedBox(width: 10,),
                          Text("Complaints",style: TextStyle(color: HexColor("#5787A6")),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }, listener: (BuildContext context, state) {},
        )
    );
  }
}

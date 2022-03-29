import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/Complaint/ComplaintInfoPage.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'dart:ui' as ui;

import 'more_of_profile_page.dart';

class MosaferProfilePage extends StatefulWidget {
  int id;

  MosaferProfilePage(this.id);

  @override
  _MosaferProfilePageState createState() => _MosaferProfilePageState();
}

class _MosaferProfilePageState extends State<MosaferProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحة العميل "),
        centerTitle: true,
      ),
      body: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: BlocProvider(
              create: (BuildContext context) =>
                  DrawerCubit()..getgetMosaferInform(id: widget.id),
              child: BlocConsumer<DrawerCubit, DrawerState>(
                  listener: (BuildContext context, state) {},
                  builder: (BuildContext context, state) {
                    if (state is GetLoadingUserInformationStates)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (state is GetSuccessUserInformationStates)
                      return Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IntrinsicHeight(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.bottomLeft,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder:
                                                          (context)=>MoreOfProfilePage(widget.id)));
                                                    },
                                                    child: ClipOval(
                                                      child: FadeInImage.assetNetwork(
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.fill,
                                                        placeholderFit: BoxFit.fill,
                                                        placeholderCacheHeight: 100,
                                                        placeholderCacheWidth: 100,
                                                        placeholder: "assets/man.png",
                                                        image: state.mosafrInformationModel
                                                            .data.photo,
                                                        imageErrorBuilder:
                                                            (context, o, c) =>
                                                                ClipOval(
                                                          child: Image.asset(
                                                            "assets/man.png",
                                                            fit: BoxFit.fill,
                                                            height: 100,
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  state.mosafrInformationModel
                                                      .data.isVerified == "1"?
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(8.0),
                                                      child: CircleAvatar(
                                                        child: Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                        radius: 10,
                                                      ),
                                                    ):SizedBox(),
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                children: [
                                                  Text(
                                                    state.mosafrInformationModel.data
                                                        .name,
                                                    style: TextStyle(
                                                        color: MyTheme.mainAppColor,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16
                                                    ),
                                                  ),
                                                  Text(
                                                    state.mosafrInformationModel
                                                        .data.isVerified == "1"?"عميل موثوق":"عميل",
                                                    style: TextStyle(
                                                        color: MyTheme.mainAppColor,
                                                      fontSize: 13
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 10,),
                                              RatingBar.builder(
                                                initialRating: int.parse(state
                                                        .mosafrInformationModel
                                                        .data
                                                        .rate)
                                                    .toDouble(),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                ignoreGestures: true,
                                                itemSize: 15,
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ), onRatingUpdate: (double value) {},
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      /*SizedBox(
                                        height: 100,
                                        child: VerticalDivider(
                                          endIndent: 10,
                                          indent: 10,
                                        ),
                                      ),*/
                                      Column(
                                        children: [
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color: MyTheme.mainAppColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: MyTheme.mainAppBlueColor,
                                width: size.width,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "الطلبات",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          child: FittedBox(
                                              child: Text(
                                            "0",
                                          )),
                                          backgroundColor: Colors.white,
                                          radius: 10,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        SVGIcons.barIcon,
                                      ],
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: VerticalDivider(
                                        endIndent: 10,
                                        indent: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "الصفقات",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          child: FittedBox(
                                              child: Text(
                                            "0",
                                          )),
                                          backgroundColor: Colors.white,
                                          radius: 10,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.work,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemBuilder: (context, index) =>
                                          CommentItem()))
                            ],
                          ),
                        ],
                      );
                    return SizedBox();
                  }))),
    );
  }
}

class CommentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: size.width * 0.9,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.mainAppBlueColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "الاسم : " + "خالد محمد صقر ",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                        ),
                        Text(
                          "رقم  الطلب :" + "22",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    child: RatingBar.builder(
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    padding: const EdgeInsets.only(left: 10),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: size.width * 0.9,
            child: Text("لا يوجد تعليق"),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey, width: 1.5)),
          )
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/bloc_add_trip.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';

import 'filed_of_add_info.dart';

class MoreInfoAddTrip extends StatelessWidget {
  Data data;

  MoreInfoAddTrip(this.data);

  TextEditingController getLocationFirstDesign = TextEditingController();
  TextEditingController getStartLocationSecondDesign = TextEditingController();
  TextEditingController getEndLocationSecondDesign = TextEditingController();
  TextEditingController getDescriptionFirstDesign = TextEditingController();
  TextEditingController getDescriptionSecondDesign = TextEditingController();
  List<TextEditingController> _controllersSecondDesign = new List();
  List<TextEditingController> _controllersThirdDesign = new List();
  TextEditingController getStartLocationThirdDesign = TextEditingController();
  TextEditingController getEndLocationThirdDesign = TextEditingController();
  TextEditingController getDescriptionThirdDesign = TextEditingController();
  TextEditingController getDescriptionFourthDesign = TextEditingController();
  List<TextEditingController> _controllersLocationFourthDesign = new List();
  List<TextEditingController> _controllersTimerFourthDesign = new List();
  TextEditingController getStartLocationFourthDesign = TextEditingController();
  TextEditingController getStartTimerFourthDesign = TextEditingController();
  TextEditingController getEndLocationFourthDesign = TextEditingController();
  TextEditingController getEndTimerFourthDesign = TextEditingController();

  var keyScaffold = GlobalKey<ScaffoldState>();
  List<String>subsectionsString = [
    "السبت",
    "الاحد",
    "الاثنين",
    "الثلاثاء",
    "الاربعاء",
    "الخميس",
    "الجمعه"
  ];
  String title = "";
  int design;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTripBloc(),
      child: BlocConsumer<AddTripBloc, AddTripStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: keyScaffold,
            appBar: AppBar(
              centerTitle: true,
              title: Text(getTitle(),
                style: TextStyle(fontFamily: "beIN"),),
            ),
            body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Only Women", style: TextStyle(
                              color: Colors.black),),
                          Spacer(),
                          Checkbox(
                              value: AddTripBloc
                                  .get(context)
                                  .valueSwitch,
                              activeColor: HexColor("#78AACC"),
                              side: BorderSide(
                                  color: HexColor("#78AACC"), width: 2),
                              splashRadius: 50,
                              onChanged: (value) {
                                AddTripBloc.get(context).changeSwitchValue(
                                    value);
                              }),
                        ],
                      ),
                    ),
                    getDesign == 0 ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: getLocationFirstDesign,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: "المدينه"
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: getDescriptionFirstDesign,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: "وصف رحلتك"
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 30,),
                        MaterialButton(
                          color: HexColor("#638462"),
                          onPressed: () {
                            AddTripBloc.get(context).createTrip(DataOfTrip());
                          },
                          child: Text("نشر الخدمة", style: TextStyle(
                              color: Colors.white),),
                        )
                      ],
                    ) :
                    getDesign() == 1 ?
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: getDescriptionSecondDesign,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: "وصف رحلتك"
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "نقطة بداية", style: TextStyle(fontWeight: FontWeight
                            .bold),),
                        getLocationDesign(getStartLocationSecondDesign),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        SizedBox(height: 20,),
                        Text(
                          "أضافة نقطه", style: TextStyle(fontWeight: FontWeight
                            .bold),),
                        GestureDetector(
                          onTap: () {
                            if (AddTripBloc
                                .get(context)
                                .itemsOfInformFieldLocation
                                .length < 2) {
                              AddTripBloc.get(context).addItemLoc(
                                  getLocationDesign(getDescriptionFirstDesign));
                            } else {
                              keyScaffold.currentState.showSnackBar(
                                  SnackBar(content:
                                  Text("نقطتين فقطة حد اقصي")));
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            _controllersSecondDesign.add(
                                new TextEditingController());
                            return getLocationDesign(
                                _controllersSecondDesign[index]);
                          },
                          itemCount: AddTripBloc
                              .get(context)
                              .itemsOfInformFieldLocation
                              .length,),
                        SizedBox(height: 20,),
                        Container(
                          height: 45,
                          width: 45,
                          child: Icon(Icons.add, color:
                          Colors.white, size: 30,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor("#638462")
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        Text("نهاية الوصول",
                          style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        getLocationDesign(getEndLocationSecondDesign),
                        Text("حدد أيام  عملك الأسبوعي ",
                          style: TextStyle(color: Colors.black),),
                        SizedBox(height: 10,),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black)
                          ),
                          height: 160,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: CheckboxGroup(
                                labels: subsectionsString,
                                labelStyle: TextStyle(color: Colors.black),
                                onSelected: (List<String> checked) =>
                                    print(checked.toString())
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        MaterialButton(
                          color: HexColor("#638462"),
                          onPressed: () {
                            AddTripBloc.get(context).createTrip(DataOfTrip(onlyWomen:"0",typeOfTrips: "2",
                                /*tripDays: [1,2,3],tripWays: [TripWays(place: "aca",time: "avd")]*/));
                          },
                          child: Text("نشر الخدمة", style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ) :
                    getDesign() == 2 ?
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: getDescriptionThirdDesign,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: "وصف رحلتك"
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("نقطة بداية", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        getLocationDesign(getStartLocationThirdDesign),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        SizedBox(height: 20,),
                        Text("أضافة نقطه", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: () {
                            getTitle();
                            if (AddTripBloc
                                .get(context)
                                .itemsOfInformFieldLocation
                                .length < 2) {
                              AddTripBloc.get(context).addItemLoc(
                                  getLocationDesign(getDescriptionFirstDesign));
                            } else {
                              keyScaffold.currentState.showSnackBar(
                                  SnackBar(content:
                                  Text("نقطتين فقطة حد اقصي")));
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              getLocationDesign(_controllersThirdDesign[index]),
                          itemCount: AddTripBloc
                              .get(context)
                              .itemsOfInformFieldLocation
                              .length,),
                        SizedBox(height: 20,),
                        Container(
                          height: 45,
                          width: 45,
                          child: Icon(Icons.add, color:
                          Colors.white, size: 30,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor("#638462")
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        Text("نهاية الوصول", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        getLocationDesign(getEndLocationThirdDesign),
                        SizedBox(height: 10,),
                        MaterialButton(
                          color: HexColor("#638462"),
                          onPressed: () {
                            AddTripBloc.get(context).createTrip(DataOfTrip());
                          },
                          child: Text("نشر الخدمة",
                            style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ) :
                    Column(
                      children: [
                        SizedBox(height: 10,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: getDescriptionFourthDesign,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                labelText: "وصف رحلتك"
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("نقطة بداية", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        FiledOfAddInfo(getStartLocationFourthDesign,
                            getStartTimerFourthDesign),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        SizedBox(height: 20,),
                        Text("أضافة نقطه", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        GestureDetector(
                          onTap: () {
                            getTitle();
                            if (AddTripBloc
                                .get(context)
                                .itemsOfInformField
                                .length < 2) {
                              AddTripBloc.get(context).addItem(FiledOfAddInfo(
                                  getDescriptionFirstDesign,
                                  getDescriptionFirstDesign));
                            } else {
                              keyScaffold.currentState.showSnackBar(
                                  SnackBar(content:
                                  Text("نقطتين فقطة حد اقصي")));
                            }
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#638462")
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              FiledOfAddInfo(
                                  _controllersLocationFourthDesign[index],
                                  _controllersTimerFourthDesign[index]),
                          itemCount: AddTripBloc
                              .get(context)
                              .itemsOfInformField
                              .length,),
                        SizedBox(height: 20,),
                        Container(
                          height: 45,
                          width: 45,
                          child: Icon(Icons.add, color:
                          Colors.white, size: 30,),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HexColor("#638462")
                          ),
                        ),
                        SizedBox(height: 20,),
                        Icon(Icons.arrow_downward_rounded, color: Colors.black,
                          size: 50,),
                        Text("نهاية الوصول", style: TextStyle(
                            fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        FiledOfAddInfo(getEndLocationFourthDesign,
                            getEndTimerFourthDesign),
                        SizedBox(height: 20,),
                        MaterialButton(
                          color: HexColor("#638462"),
                          onPressed: () {
                            AddTripBloc.get(context).createTrip(DataOfTrip());
                          },
                          child: Text("نشر الخدمة",
                            style: TextStyle(color: Colors.white),),
                        )
                      ],
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }

  String getTitle() {
    if (data.twoPlace == "0") {
      title = "خدمات المدن";
    } else if (data.weekly == "1") {
      title = "رحلة أسبوعية";
      print(title);
    } else if (data.specialDlivery == "1") {
      title = "تعديل ونشر الرحلة";
    } else {
      title = "رحلة حسب الطلب";
    }
    return title;
  }

  int getDesign() {
    if (data.twoPlace == "0") {
      design = 0;
    } else if (data.weekly == "1") {
      design = 1;
      print(title);
    } else if (data.specialDlivery == "1") {
      design = 2;
    } else {
      design = 3;
    }
    return design;
  }

  Widget getLocationDesign(TextEditingController editingController) {
    return Container(
      height: 40,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          controller: editingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              labelText: "المدينه"
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}



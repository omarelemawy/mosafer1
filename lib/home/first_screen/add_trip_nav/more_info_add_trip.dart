
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/bloc_add_trip.dart';
import 'package:mosafer1/home/first_screen/add_trip_nav/bloc/state_add_trip.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/model/get-all-main-trip-categorires.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/styles/thems.dart';

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
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
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
                            Text("خدمات للنساء فقط", style: TextStyle(
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
                      data.id == 4 ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getLocationFirstDesign,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  labelText: "وصف رحلتك"
                              ),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 30,),
                          state is CreateTripLoadingStates?CircularProgressIndicator():
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                fromPlace: getLocationFirstDesign.text,
                                description: getDescriptionFirstDesign.text
                              ),data.id,context).then((value) {
                                if(value==true){
                                  Utils().showMyDialog(SimpleInformDialog(
                                    title: "أدارة مسافر",
                                    body: "تم أضافة رحلة",
                                    icon: Image.asset("assets/logo1.png"),
                                  ),context);
                                }
                              });
                            },
                            child: Text("نشر الخدمة", style: TextStyle(
                                color: Colors.white),),
                          ),
                          SizedBox(height: 15,)
                        ],
                      ) :
                      data.id == 2 ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getDescriptionSecondDesign,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                          state is CreateTripLoadingStates?CircularProgressIndicator():
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(
                                  DataOfTrip(
                                    description: getDescriptionSecondDesign.text,
                                    fromPlace: getStartLocationSecondDesign.text,
                                    toPlace: getEndLocationSecondDesign.text
                                  ),data.id,context).then((value) {
                                if(value==true){
                                  Utils().showMyDialog(SimpleInformDialog(
                                    title: "أدارة مسافر",
                                    body: "تم أضافة رحلة",
                                    icon: Image.asset("assets/logo1.png"),
                                  ),context);
                                }
                              });;
                            },
                            child: Text("نشر الخدمة", style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(height: 15,)
                        ],
                      ) :
                      data.id == 3 ?
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: getDescriptionThirdDesign,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                            itemBuilder: (context, index) {
                              _controllersThirdDesign.add(new TextEditingController());
                              return  getLocationDesign(
                                      _controllersThirdDesign[index]);
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
                          Text("نهاية الوصول", style: TextStyle(
                              fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          getLocationDesign(getEndLocationThirdDesign),
                          SizedBox(height: 10,),
                          state is CreateTripLoadingStates?CircularProgressIndicator():
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                description: getDescriptionThirdDesign.text,
                                fromPlace: getStartLocationThirdDesign.text,
                                toPlace: getEndLocationThirdDesign.text
                              ),data.id,context).then((value) {
                                if(value==true){
                                  Utils().showMyDialog(SimpleInformDialog(
                                    title: "أدارة مسافر",
                                    body: "تم أضافة رحلة",
                                    icon: Image.asset("assets/logo1.png"),
                                  ),context);
                                }
                              });;
                            },
                            child: Text("نشر الخدمة",
                              style: TextStyle(color: Colors.white),),
                          ),SizedBox(height: 15,)
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
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                          FiledOfAddInfo(getStartTimerFourthDesign,
                            getStartLocationFourthDesign,),
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
                            itemBuilder: (context, index) {
                              _controllersLocationFourthDesign.add(new TextEditingController());
                              _controllersTimerFourthDesign.add(new TextEditingController());
                              return FiledOfAddInfo(
                                _controllersTimerFourthDesign[index],
                                      _controllersLocationFourthDesign[index],
                                    );
                            },
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
                          FiledOfAddInfo(getEndTimerFourthDesign,
                            getEndLocationFourthDesign,
                              ),
                          SizedBox(height: 20,),
                          state is CreateTripLoadingStates?CircularProgressIndicator():
                          MaterialButton(
                            color: HexColor("#638462"),
                            onPressed: () {
                              AddTripBloc.get(context).createTrip(DataOfTrip(
                                description: getDescriptionFourthDesign.text,
                                fromPlace:getStartLocationFourthDesign.text,
                                toPlace: getEndLocationFourthDesign.text,
                                startDate: getStartTimerFourthDesign.text,
                                endDate: getEndTimerFourthDesign.text
                              ),data.id,context).then((value) {
                                if(value==true){
                                  Utils().showMyDialog(SimpleInformDialog(
                                    title: "أدارة مسافر",
                                    body: "تم أضافة رحلة",
                                    icon: Image.asset("assets/logo1.png"),
                                  ),context);
                                }
                              });
                            },
                            child: Text("نشر الخدمة",
                              style: TextStyle(color: Colors.white),),
                          ),
                          SizedBox(height: 15,)
                        ],
                      ),
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  String getTitle() {
    if (data.id == 4) {
      title = "خدمات المدن";
    } else if (data.id == 2) {
      title = "رحلة أسبوعية";
      print(title);
    } else if (data.id == 1) {
      title = "تعديل ونشر الرحلة";
    } else {
      title = "رحلة حسب الطلب";
    }
    return title;
  }

  int getDesign() {
    if (data.twoPlace == "0") {
      design = 0;
    } else if (data.weekly == "1")
    {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: editingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            labelText: "المدينه"
        ),
        maxLines: 1,
      ),
    );
  }
}

class SimpleInformDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  const SimpleInformDialog({Key key, this.icon, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: size.width,
              margin: const EdgeInsets.only(left: 40,right: 40,top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()),
                            (route) => false);
                  }, child: Icon(Icons.close,color: MyTheme.mainAppColor,),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all( Colors.white),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),),
                  Padding(
                    child:   Align(
                      child: Text(body,style: TextStyle(color: Colors.white),),
                      alignment: Alignment.center,
                    ),
                    padding: const EdgeInsets.only(bottom: 30,top: 20),
                  )
                ],
              ),
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
              decoration: BoxDecoration(
                  color: MyTheme.mainAppColor,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: icon,
            )
          ],
        ),
      ),);
  }
}



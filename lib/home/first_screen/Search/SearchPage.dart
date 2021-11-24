import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/Travel/TravelDetails.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_cubit.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Widgets/CustomAppBar.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _groupVal = 0;
  bool _ladies = false;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(
          title: "بحث",
        ),
        preferredSize: Size.fromHeight(60),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(
                    8,
                    (index) => Row(
                      mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio(
                                value: index,
                                groupValue: _groupVal as int,
                                onChanged: (val) {
                                  print(val);
                                  setState(() {
                                    _groupVal = val;
                                  });
                                }),
                            Text("اختيار"),
                          ],
                        )),
              ),
              Row(
                children: [
                  Checkbox(value: _ladies, onChanged: (val){
                    setState(() {
                      _ladies = val;
                    });
                  }),
                  Text("رحلات سيدات")
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 15,),
                  Expanded(
                    child: TextField(

                      decoration: InputDecoration(
                        labelText: "مدينة",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: MyTheme.mainAppBlueColor)
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: TextField(

                      decoration: InputDecoration(
                        labelText: "مدينة",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: MyTheme.mainAppBlueColor)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                ],
              ),
              const SizedBox(height: 10,),
              Align(
                child: ElevatedButton(child: Text("بحث"),onPressed: (){},style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyTheme.mainAppBlueColor),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(size.width*0.9)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                ),),
                alignment: Alignment.center,
              ),
              Divider(indent: 20,endIndent: 20,height: 10,color: MyTheme.mainAppBlueColor.withOpacity(0.3),),
              Expanded(
                child: BlocProvider(
                  create: (BuildContext context) => HomeCubit()..getAllServices(),
                  child: BlocConsumer<HomeCubit,HomeStates>(
                    builder: (context,state){
                      List<RequestServices> allRequestsSe = HomeCubit.get(context).allRequestsSe;
                      return state is GetLoadingAllRequestServicesStates?
                      Center(child: CircularProgressIndicator()):Padding(
                        padding: const EdgeInsets.only(bottom: 20.0,top: 10,right: 10,left: 10),
                        child: ListView.separated(itemBuilder: (context,index)=>
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: HexColor("#90AC7A")),),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:MyTheme.mainAppBlueColor,
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(allRequestsSe[index].photo),
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
                                        ),
                                        SizedBox(width: 7),
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
                                                    child: Text(allRequestsSe[index].user==null?"":
                                                    allRequestsSe[index].user.name,
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
                                                  Text(allRequestsSe[index].fromPlace==null?"":
                                                  allRequestsSe[index].fromPlace,
                                                    style: TextStyle(fontFamily: "beIN",
                                                        fontWeight: FontWeight.bold,
                                                        color:HexColor("#707070")
                                                    ),),
                                                  Icon(Icons.chevron_right_rounded),
                                                  Expanded(
                                                    child: Text(allRequestsSe[index].toPlace==null?
                                                    "":allRequestsSe[index].toPlace,
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
                                                    child: Text(allRequestsSe[index].description==null?"":
                                                    allRequestsSe[index].description,
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
                                                  Text(allRequestsSe[index].maxDay==null?"":
                                                  allRequestsSe[index].maxDay, style: TextStyle(fontFamily: "beIN",
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
                                  Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          color : MyTheme.mainAppBlueColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10,),
                                            Image.asset("assets/icon_home.png"),
                                            Spacer(),
                                            ElevatedButton(onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder:
                                                  (context)=> TravelDetailsPage(requestServices: allRequestsSe[index],)));
                                            },
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                                                )
                                                , child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("دخول",style:
                                                    TextStyle(fontFamily: "beIN",fontSize: 14,color: MyTheme.mainAppColor),),
                                                    Icon(Icons.chevron_right,color: MyTheme.mainAppColor,),
                                                  ],
                                                ))
                                            ,
                                            SizedBox(width: 10,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          itemCount: allRequestsSe.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 20,);
                          },
                        ),
                      );
                    },
                    listener: (context,state){},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

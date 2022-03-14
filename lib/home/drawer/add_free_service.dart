import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class AddFreeService extends StatefulWidget {
  const AddFreeService({Key key}) : super(key: key);

  @override
  _AddFreeServiceState createState() => _AddFreeServiceState();
}

class _AddFreeServiceState extends State<AddFreeService> {
  File _fileFirstDesign;
  TextEditingController getDescription = TextEditingController();
  TextEditingController getEndLocationThirdDesign = TextEditingController();
  TextEditingController getTypeOfServiceDesign = TextEditingController();
  List<TextEditingController> _controllersSecondDesign = new List();
  var keyScaffold = GlobalKey<ScaffoldState>();
  Future getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if(result != null) {
      _fileFirstDesign = File(result.files.single.path.toString());
    } else
    {
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>DrawerCubit(),
      child: BlocConsumer<DrawerCubit,DrawerState>(
        builder: (context,state){
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              key: keyScaffold,
              appBar: AppBar(
                centerTitle: true,
                title: Text("أضافة خدمة مجانيه"),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("ماهي  الخدمة المجانية  المقدمة ؟",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: getTypeOfServiceDesign,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: "المدينه"
                        ),
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        getFile().then((value) {
                          DrawerCubit.get(context).getImageFirstDesign();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)
                        ),
                        height: 100,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: _fileFirstDesign==null?Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.cloud_upload,color: MyTheme.mainAppColor,
                              size: 40,
                            ),
                            SizedBox(width: 10,),
                            Text("أرفق صورة لطلبك",style:
                            TextStyle(color: MyTheme.mainAppBlueColor,fontSize: 12),)
                          ],
                        ):
                        Image.file(_fileFirstDesign,fit: BoxFit.cover,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         if (DrawerCubit
                        .get(context)
                        .itemsOfInformFieldLocation
                        .length < 3) {
                           DrawerCubit.get(context).addItemLoc(
                          getLocationDesign(new TextEditingController()));
                    } else {
                      keyScaffold.currentState.showSnackBar(
                          SnackBar(content:
                          Text("3 مدن فقطة حد اقصي")));
                    }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color:
                            Colors.white, size: 30,),
                            Text("أضافة مدينه",style: TextStyle(color: Colors.white),)
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            color: HexColor("#638462")
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        _controllersSecondDesign.add(
                            new TextEditingController());
                        return getLocationDesign(
                            _controllersSecondDesign[index]);
                      },
                      itemCount: DrawerCubit
                          .get(context)
                          .itemsOfInformFieldLocation
                          .length,),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: getDescription,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            labelText: "وصف رحلتك"
                        ),
                        maxLines: 3,
                      ),
                    ),
                    state is CreateFreeServiceLoadingStates?CircularProgressIndicator():
                    MaterialButton(
                      color: HexColor("#638462"),
                      onPressed: () {
                        DrawerCubit.get(context).createTrip(
                            getDescription.text, getTypeOfServiceDesign.text,
                           _fileFirstDesign,
                            _controllersSecondDesign.length>0?_controllersSecondDesign[0].text:"",
                            _controllersSecondDesign.length>1?_controllersSecondDesign[1].text:"",
                            _controllersSecondDesign.length>2? _controllersSecondDesign[2].text:""
                            ,context);
                      },
                      child: Text("نشر الخدمة", style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 15,)
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){},
      ),
    );
  }
  Widget getLocationDesign(TextEditingController editingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
      child: TextFormField(
        controller: editingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
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

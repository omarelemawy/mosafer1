import 'dart:io';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';



class MoreRegisterInfo extends StatelessWidget {
   MoreRegisterInfo({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController nationalNumberController=TextEditingController();
  TextEditingController carCardController=TextEditingController();
  TextEditingController carModeController=TextEditingController();
  TextEditingController carNameController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String nationality="Saudi Arabia";
   final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
   File _fileProfile;
   File _fileCarCard;
   File _fileCarPhoto;
   File _fileCarSide;
   File _fileGetImageNat;
   File _fileGetImagePerm;
   Future getFile(i) async {
     FilePickerResult result = await FilePicker.platform.pickFiles();
     if(result != null) {
       switch(i){
         case 1:
           _fileProfile = File(result.files.single.path.toString());
           break;
         case 2:
           _fileCarCard = File(result.files.single.path.toString());
           break;
         case 3:
           _fileCarPhoto = File(result.files.single.path.toString());
           break;
         case 4:
           _fileCarSide = File(result.files.single.path.toString());
           break;
         case 5:
           _fileGetImageNat = File(result.files.single.path.toString());
           break;
         case 6:
           _fileGetImagePerm = File(result.files.single.path.toString());
           break;
       }
     } else
       {
       }
   }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>LoginBloc(),
        child: BlocConsumer<LoginBloc,LoginStates>(
          listener:(context,state){} ,
          builder: (context,state){
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                  key:keyScaffold,
                  body: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                            color: HexColor("#77975E")
                        ),

                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(120),topLeft:  Radius.circular(120)),
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 80,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        getFile(1).then((value) {
                                          LoginBloc.get(context).getUserImage();
                                        });
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage:_fileProfile==null? AssetImage("assets/man.png"):FileImage(_fileProfile),
                                            backgroundColor: Colors.grey[300],
                                          ),
                                          Icon(Icons.cloud_upload_rounded,color: HexColor("#638462"),size: 30,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      child: Text("أرفع صورة حقيقة لتصبح مسافر موثوق",
                                        style: TextStyle(
                                            fontFamily: "beIN",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor("#638462")
                                        ),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        getFile(2).then((value) {
                                          LoginBloc.get(context).getCarImage1();
                                        });
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage:_fileCarCard==null? AssetImage("assets/circle.jpg"):
                                            FileImage(_fileCarCard),
                                            backgroundColor: Colors.grey[300],
                                            child: _fileCarCard!=null?Container():Center(child:
                                            Text("لوحة السيارة",style: TextStyle(fontSize: 11),)),
                                          ),
                                          Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        getFile(3).then((value) {
                                          LoginBloc.get(context).getCarImage2();
                                        });
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage:_fileCarPhoto==null? AssetImage("assets/circle.jpg"):FileImage(_fileCarPhoto),
                                            backgroundColor: Colors.grey[300],
                                            child: _fileCarPhoto!=null?Container():Center(child: Text("صورة للسياره",
                                                style: TextStyle(fontSize: 12))),
                                          ),
                                          Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        getFile(4).then((value) {
                                          LoginBloc.get(context).getCarImage3();
                                        });
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage:_fileCarSide==null? AssetImage("assets/circle.jpg"):FileImage(_fileCarSide),
                                            backgroundColor: Colors.grey[300],
                                            child: _fileCarSide!=null?Container():Center(child: Text("صورة جانبية",
                                                style: TextStyle(fontSize: 12))),
                                          ),
                                          Icon(Icons.add,color: HexColor("#638462"),size: 30,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("الهوية :",style: TextStyle(
                                      color: Colors.green
                                    ),),
                                    CountryListPick(
                                        appBar: AppBar(
                                          backgroundColor: Colors.blue,
                                          title: Text('Choisir un pays'),
                                        ),
                                        theme: CountryTheme(
                                          isShowFlag: true,
                                          isShowTitle: true,
                                          isShowCode: true,
                                          isDownIcon: true,
                                          showEnglishName: true,
                                        ),
                                        // Set default value
                                        initialSelection: '+966',
                                        // or
                                        // initialSelection: 'US'
                                        onChanged: (CountryCode code) {
                                          nationality=code.name;
                                          print(code.name);
                                          print(code.code);
                                          print(code.dialCode);
                                          print(code.flagUri);
                                        },
                                        // Whether to allow the widget to set a custom UI overlay
                                        useUiOverlay: true,
                                        // Whether the country list should be wrapped in a SafeArea
                                        useSafeArea: false
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*مطلوب";
                                    }
                                    return null;
                                  },
                                  controller: nationalNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    labelText: "رقم الهوية",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .26,
                                      child: TextFormField(
                                        controller: carCardController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  "*مطلوب";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                            labelText: "موديلها",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            )
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .3,
                                      child: TextFormField(
                                        controller: carModeController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  "*مطلوب";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                            labelText: "لوحة السيارة",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            )
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .3,

                                      child: TextFormField(
                                        controller: carNameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  "*مطلوب";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                                            labelText: "أسم السيارة",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    getFile(5).then((value) {
                                      LoginBloc.get(context).getImageNat();
                                    });
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsets.symmetric(horizontal:50),
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: _fileGetImageNat ==null?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Icon(Icons.add,color:
                                            Colors.white,size: 30,),
                                           decoration: BoxDecoration(
                                             color: Colors.green,
                                             shape: BoxShape.circle
                                           ),
                                        ),
                                        Text("أرفع صورة الهوية او الإقامة او الجواز",style: TextStyle(color: Colors.grey),)
                                      ],
                                    ):Image.file(_fileGetImageNat,fit: BoxFit.cover,),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){
                                    getFile(6).then((value)
                                    {
                                      LoginBloc.get(context).getImageNat();
                                    }
                                    );
                                  },
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    margin: EdgeInsets.symmetric(horizontal:50),
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:_fileGetImagePerm ==null?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Icon(Icons.add,color:
                                          Colors.white,size: 30,),
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        Text("أرفع صورة الإستمارة أو الرخصة",style: TextStyle(color: Colors.grey),)
                                      ],
                                    ):
                                    Image.file(_fileGetImagePerm,fit: BoxFit.cover,)
                                  ),
                                ),
                                SizedBox(height: 10,),
                                state is RegisterLoadingState?
                                CircularProgressIndicator(
                                  color: HexColor("#77975E"),
                                ):
                               state is AddMoreInformOfMosaferLoadingStates?CircularProgressIndicator():
                               Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: HexColor("#77975E"),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:  MaterialButton(
                                    onPressed: (){
                                          if (_formKey.currentState
                                              .validate() &&
                                              _fileProfile != null&&_fileCarCard!= null&&
                                              _fileCarPhoto != null&&_fileCarSide!= null&&
                                              _fileGetImageNat != null&&_fileGetImagePerm!= null) {
                                            LoginBloc.get(context).addMoreInformOfMosafer(
                                                CacheHelper.getData(key: "id"),
                                                nationalNumberController.text,
                                                nationality,
                                                 carNameController.text,
                                                carModeController.text,
                                              carCardController.text,
                                              _fileProfile,
                                              _fileGetImagePerm,
                                              _fileGetImageNat,
                                              _fileCarCard,_fileCarPhoto,context
                                            );
                                          } else {
                                            keyScaffold.currentState
                                                .showSnackBar(const
                                            SnackBar(content: Text(
                                              "تأكد من وجود جميع الصور",
                                              style:
                                              TextStyle(color: Colors
                                                  .white),),
                                              backgroundColor: Colors
                                                  .blue,));
                                          }
                                    },
                                    child: Text(
                                        "ارسال"
                                        ,style: TextStyle(
                                        fontFamily: "beIN",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
              ),
            );
          },
        )
    );
  }

}

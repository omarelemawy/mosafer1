import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';

class SignUp extends StatelessWidget {
   SignUp({Key key}) : super(key: key);

  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController passController=TextEditingController();
   String replaceAll="966";
   TextEditingController passCheckController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
   File _file;

   Future getFile() async {
     FilePickerResult result = await FilePicker.platform.pickFiles();

     if(result != null) {
       _file = File(result.files.single.path.toString());
     } else {
     }

   }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>LoginBloc(),
        child: BlocConsumer<LoginBloc,LoginStates>(
          listener:(context,state){
            if(state is RegisterErrorState)
            {
              keyScaffold.currentState.showSnackBar(SnackBar(content: Text(state.error))) ;
            }
          } ,
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
                                Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Row(
                                      children: [
                                        IconButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, icon:
                                        Icon(Icons.arrow_back_ios_outlined,color: Colors.white,)),
                                        Spacer(),
                                        Image.asset("assets/sign_up.png")
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        getFile().then((value) {
                                          LoginBloc.get(context).getImage();
                                        });
                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          CircleAvatar(
                                            radius: 45,
                                            backgroundImage:_file==null? AssetImage("assets/man.png"):FileImage(_file),
                                            backgroundColor: Colors.grey[300],
                                          ),
                                          Icon(Icons.cloud_upload_rounded,color: HexColor("#638462"),size: 30,)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Text("التسجيل",
                                        style: TextStyle(
                                            fontFamily: "beIN",
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor("#638462")
                                        ),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CountryCodePicker(
                                      onChanged: _onCountryChange,
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'SA',
                                      favorite: ['+966','SA'],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return  "*مطلوب";
                                          }
                                          return null;
                                        },
                                        controller: phoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                            prefixIcon: Icon(Icons.phone,color: HexColor("#638462"),),
                                            labelText: "رقم الجوال",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*مطلوب";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      prefixIcon: Icon(Icons.email,color: HexColor("#638462"),),
                                      labelText: "البريد الالكتروني",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*مطلوب";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      prefixIcon: Icon(Icons.person,color: HexColor("#638462"),),
                                      labelText: "الاسم",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  controller: passController,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*مطلوب";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      prefixIcon: Icon(Icons.lock,color: HexColor("#638462"),),
                                      labelText: "كلمة المرور",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                      prefixIcon: Icon(Icons.lock,color: HexColor("#638462"),),
                                      labelText: "تأكيد كلمة المرور",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20)
                                      )
                                  ),
                                  controller: passCheckController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return  "*مطلوب";
                                    }
                                    return null;
                                  },
                                ),
                                Row(
                                  children: [
                                    Text( "النوع",style:
                                    const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                                    SizedBox(width: 20,),
                                    Radio<SingingCharacter>(
                                      value: SingingCharacter.Male,
                                      groupValue: LoginBloc.get(context).character,
                                      onChanged: (SingingCharacter value)
                                      {
                                        LoginBloc.get(context).changeGender(value);
                                      },
                                    ),
                                    Text("ذكر",style:
                                    const TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold,fontSize: 16),),
                                    Radio<SingingCharacter>(
                                      value: SingingCharacter.FeMale,
                                      groupValue: LoginBloc.get(context).character,
                                      onChanged: (SingingCharacter value)
                                      {
                                        LoginBloc.get(context).changeGender(value);
                                      },
                                    ),
                                    Text( "أنثي",style:
                                    const TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold,fontSize: 16),),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Text("لقد قرأت سياسة وشروط التطبيق وأتعهد بالالتزام بها",
                                      style:  TextStyle(color: HexColor("#638462"),
                                          height: 2,
                                          fontWeight: FontWeight.bold,fontSize: 14),),
                                    Container(
                                      height: 70,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Spacer(),
                                          Checkbox(
                                              value: LoginBloc.get(context).valueSwitch,
                                              activeColor: HexColor("#78AACC"),
                                              side: BorderSide(color: HexColor("#78AACC"),width: 2),
                                              splashRadius: 50,
                                              onChanged: (value){
                                                LoginBloc.get(context).changeSwitchValue(value);
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                state is RegisterLoadingState? CircularProgressIndicator(
                                  color: HexColor("#77975E"),
                                ):
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: HexColor("#77975E"),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:  MaterialButton(
                                    onPressed: (){
                                      if (LoginBloc.get(context)
                                          .valueSwitch) {
                                        if (passController.text ==
                                            passCheckController.text) {
                                          if (_formKey.currentState
                                              .validate() &&
                                              _file != null) {
                                            print(replaceAll);
                                            LoginBloc.get(context)
                                                .uploadFile(
                                                _file,
                                                context,
                                                nameController.text,
                                                emailController.text,
                                                phoneController.text,
                                                passController.text,
                                                LoginBloc.get(context).character
                                                    == SingingCharacter.Male? "0" : "1",
                                                replaceAll
                                            );
                                          } else {
                                            keyScaffold.currentState
                                                .showSnackBar(const
                                            SnackBar(content: Text(
                                              "من فضلك أختر صورة",
                                              style:
                                              TextStyle(color: Colors
                                                  .white),),
                                              backgroundColor: Colors
                                                  .blue,));
                                          }
                                        } else {
                                          keyScaffold.currentState
                                              .showSnackBar(const
                                          SnackBar(content: Text(
                                            "من فضلك تحقق من تأكيد كلمة المرور",
                                            style:
                                            TextStyle(color: Colors
                                                .white),),
                                            backgroundColor: Colors
                                                .blue,));
                                        }
                                      }else{
                                        keyScaffold.currentState
                                            .showSnackBar(
                                            SnackBar(content: Text(
                                                "أوافق علي الشروط والسياسات",
                                              style:
                                              const TextStyle(color: Colors
                                                  .white),),
                                              backgroundColor: Colors
                                                  .blue,));
                                      }
                                    },
                                    child: Text(
                                        "أنشاء"
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

   void _onCountryChange(CountryCode countryCode) {
     //TODO : manipulate the selected country code here
     print(countryCode.toString().replaceAll(new RegExp(r'[^\w\s]+'),''));
      replaceAll = countryCode.toString().replaceAll(new RegExp(r'[^\w\s]+'),'');
   }
}

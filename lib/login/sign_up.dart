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
          listener:(context,state){} ,
          builder: (context,state){
            return Scaffold(
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
                            SizedBox(height: 20,),
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
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text("التسجيل",
                                    style: TextStyle(
                                        fontFamily: "beIN",
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor("#5787A6")
                                    ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CountryCodePicker(
                                  onChanged: print,
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
                                  child: Container(
                                    child: TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone,color: HexColor("#638462"),),
                                          labelText: "Phone",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email,color: HexColor("#638462"),),
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.person,color: HexColor("#638462"),),
                                  labelText: "Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: passController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock,color: HexColor("#638462"),),
                                  labelText: "PassWord",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                            SizedBox(height: 40,),
                            state is LoginLoadingState? CircularProgressIndicator(
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
                                  LoginBloc.get(context).loginUser(context, emailController.text, passController.text);
                                },
                                child: Text(
                                    "Create"
                                    ,style: TextStyle(
                                    fontFamily: "beIN",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            );
          },
        )
    );
  }
}

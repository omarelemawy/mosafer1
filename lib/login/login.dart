import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:mosafer1/login/sign_up.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'bloc/cubit.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginBloc(),
      child: BlocConsumer<LoginBloc,LoginStates>(
        listener:(context,state){} ,
        builder: (context,state){
          return Scaffold(
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          color: MyTheme.mainAppBlueColor
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
                              borderRadius: BorderRadius.only(topRight:
                              Radius.circular(120),topLeft:  Radius.circular(120)),
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 90,),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Image.asset("assets/logo1.png")
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 50,),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: Text("اهلا",style:
                                      TextStyle(
                                          fontFamily: "beIN",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                      ),),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()
                                          ), (route) => false);
                                        },
                                        child: Text("تخطي",style:
                                        TextStyle(
                                            fontFamily: "beIN",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            decoration:TextDecoration.underline
                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 100,),
                            Text("دخول العملاء",
                              style: TextStyle(
                                  fontFamily: "beIN",
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor("#5787A6")
                              ),),
                            SizedBox(height: 70,),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "البريد الالكتروني / الهاتف",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: passController,
                              decoration: InputDecoration(
                                  labelText: "كلمة السر",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("نسيت كلمة السر",style: TextStyle(
                                    fontFamily: "beIN",
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                    color: MyTheme.mainAppBlueColor)),
                                SizedBox(width: 5,),
                                Image.asset("assets/refrech.png")
                              ],
                            ),
                            SizedBox(height: 15,),
                            state is LoginLoadingState? CircularProgressIndicator(
                              color: MyTheme.mainAppBlueColor,
                            ):
                            Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: MyTheme.mainAppBlueColor,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:  MaterialButton(
                                onPressed: (){
                                  LoginBloc.get(context).loginUser(context, emailController.text, passController.text);
                                },
                                child: Text(
                                    "تسجيل الدخول"
                                    ,style: TextStyle(
                                    fontFamily: "beIN",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                            },
                              child: Text("انشاء حساب جديد",style: TextStyle(
                                  fontFamily: "beIN",
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  color: HexColor("#5787A6"))),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        },
      )
    );
  }
}


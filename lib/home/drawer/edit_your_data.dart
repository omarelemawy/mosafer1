import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/bloc/cubit_drawer.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';


class EditYourData extends StatelessWidget {
   EditYourData({Key key}) : super(key: key);
  TextEditingController emailController=TextEditingController();
  TextEditingController nationalController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController passController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DrawerCubit(),
        child: BlocConsumer<DrawerCubit, DrawerState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("تعديل بياناتك"),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        Container(
                          height: 50,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  "*Required";
                              }
                              return null;
                            },
                            controller: nationalController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity,color: HexColor("#638462"),),
                              labelText: "National Id",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  "*Required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email,color: HexColor("#638462"),),
                                labelText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  "*Required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,color: HexColor("#638462"),),
                                labelText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          child: TextFormField(
                            controller: passController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return  "*Required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,color: HexColor("#638462"),),
                                labelText: "PassWord",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 50,),
                        state is EditProfileLoadingStates?
                        Center(child: CircularProgressIndicator()):
                        Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HexColor("#77975E"),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:  MaterialButton(
                            onPressed: (){
                              if(_formKey.currentState
                                  .validate()){
                                DrawerCubit.get(context).editProfile(context,nameController.text,
                                    nationalController.text, 1, emailController.text,
                                    passController.text);
                              }
                            },
                            child: Text(
                                "Edit"
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
              ),
            );
          },
        )
    );
  }
}

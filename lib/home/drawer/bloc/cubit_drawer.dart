import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/model/mosafer_information_model.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:http/http.dart'as http;

class DrawerCubit extends Cubit<DrawerState>{
  DrawerCubit() : super(InitialDrawerState());
  static DrawerCubit get(context) => BlocProvider.of(context);
  MosafrInformationModel mosafrInformationModel;

  Future<MosafrInformationModel> getMosafrInformation () async {
    emit(GetLoadingMosaferInformationStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/get-masafr-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(GetSuccessMosaferInformationStates());
      print(response.body);
      return MosafrInformationModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      print(response.body);
      emit(GetErrorMosaferInformationStates(json['msg']));
    }
  }
  void getgetMosafrInform()
  {
    getMosafrInformation().then((value) {
      mosafrInformationModel  = value;
    });
  }
  Future editProfile (context,name,national_id_number,gender,email,password) async {
    emit(EditProfileLoadingStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/update-masafr-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    Map<String, String> mapData1 = {
      "name": name,
      "national_id_number": national_id_number,
      "gender": "0",
      "email": email,
      "password": password,
    };

    final response = await http.post(Api,headers: mapData,body:mapData1);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      emit(EditProfileSuccessStates());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()
      ), (route) => false);
      print(json);
    } else {
      final json = jsonDecode(response.body);
      emit(EditProfileErrorStates(json['msg']));
    }

  }
}
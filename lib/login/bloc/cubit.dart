import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/BottomNavigation/homeScreen.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';


class LoginBloc extends Cubit<LoginStates>{
  LoginBloc() : super(InitialLoginStates());
  static LoginBloc get(context) => BlocProvider.of(context);

  Future loginUser(context,email,pass) async {
    emit(LoginLoadingState());
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/masafr/login');
    Map mapData = {
      'phone': email,
      'password': pass,
    };
    http.Response response = await http.post(APIURL, body: mapData);

    if (response.statusCode == 200) {
      emit(LoginSuccessState());
      print(response.body);
      var data = jsonDecode(response.body);
      if(data["status"]){
        var token = data["msg"]["token"];
        var id = data["msg"]["id"];
        print(token);
        CacheHelper.saveData(key: 'token', value: token);
        CacheHelper.saveData(key: 'email', value: email);
        CacheHelper.saveData(key: 'id', value: id);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>
            HomeScreen()), (context) => false);
      }else{
        emit(LoginErrorState(data["msg"]));
      }

    } else
    {
      print(response.body);
      emit(LoginErrorState("Please Check Email or Password"));
    }
  }
  void getImage()
  {
    emit(RegisterGetImageState());
  }
}
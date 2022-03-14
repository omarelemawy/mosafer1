import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/Fatorah/AddServiceWidget.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';


class FatorahCubit extends Cubit<FatorahState>{
  FatorahCubit() : super(InitialFatorahState());
  static FatorahCubit get(context) => BlocProvider.of(context);
  String serviceName = "";
  String servicePrice = "";
  HttpOps _httpOps = HttpOps();
  List<AddService> addServicesList = [AddService()];
  Map<String,dynamic> totalServicesMap = {"0" : {"price" : "0", "serviceName" : ""}};

  int totalPrice = 0;

  void addMoreService() {
    addServicesList.add(AddService());
    emit(MoreServicesFatorahState());
  }

  void addService(int index,String serviceName ,String price)
  {
    totalServicesMap.update("$index",
            (value) => {
      "price" : price,
      "serviceName" : serviceName
    },
      ifAbsent: () => {
      "price" : price,
      "serviceName" : serviceName}
    );
    print("Total : $totalServicesMap");
  }


  void calculateTotalServicesPrice(){
    totalPrice = 0;
    totalServicesMap.forEach((key, value) {
      totalPrice += int.parse(value["price"]);
    });
    print("Total price : $totalPrice");
    emit(NewTotalPriceState("$totalPrice .00"));
  }

  bool fatorahValidation() {
    return totalServicesMap["0"]["price"] != "0" && totalServicesMap["0"]["serviceName"] != "";
  }

  Future<FatorahService> createNewFatorah({int chatId })  async {
    List<Map> fatoorahServices = [];
    var dio = Dio();
    Response response;
    totalServicesMap.forEach((key, value) {
      fatoorahServices.add({"subject":value["serviceName"], "value":int.parse(value["price"])});
    });
    Map data = {
      "chat_ids": chatId ,
      "fatoorahs" : fatoorahServices
    };
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    response = await dio.post("https://msafr.we-work.pro/api/auth/masafr/create-fatoorah",
        data: data,options: Options(headers:mapData ));


    print("Data $data");

    print(response.data["data"]);
    return FatorahService.fromJson(response.data["data"]);

  }
}
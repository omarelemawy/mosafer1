import 'dart:convert';
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

  HttpOps _httpOps = HttpOps();
  List<AddService> addServicesList = [AddService()];
  Map<String,dynamic> totalServicesMap = {"0" : {"price" : "0", "serviceName" : ""}};

  int totalPrice = 0;

  void addMoreService() {
    addServicesList.add(AddService());
    emit(MoreServicesFatorahState());
  }

  void addServiceData(int index,String serviceName ,String price) {
    totalServicesMap.update("$index", (value) => {
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

  void createNewFatorah({int chatId })  async {
    List<Map> fatoorahServices = [];
    totalServicesMap.forEach((key, value) {
      fatoorahServices.add({"subject":value["serviceName"].toString(), "value":int.parse(value["price"])});
    });

    Map data = {
      "chat_id": 1 ,
      "fatoorahs" : fatoorahServices
    };

    print("Data $data");

    GetAllRequestServicesModel requestServicesModel = await _httpOps.postData(mapData: data,endPoint: addNewFatorahUrl ,auth: true);
    print(requestServicesModel.data);

  }
}
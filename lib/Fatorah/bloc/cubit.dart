import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/Fatorah/AddServiceWidget.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:toast/toast.dart';


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

  Future<FatorahService> createNewFatorah({int chatId ,context})  async {
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

    if(response.data["status"]==true) {
      print("Data111 ${response.data}");
      return FatorahService.fromJson(response.data["data"]);
    }else{
      print("dddddddddddddddddddd");
      ToastView.createView(response.data["msg"], context, 4, Toast.CENTER, Colors.grey, Colors.white
          , 20, Border.all(color: Colors.black,width: 1));
     /* Utils().showMyDialog(SimpleIconDialogFatorah(
        title: "أدارة مسافر",
        body: response.data["msg"],
        icon: Icon(Icons.home),
      ),context);*/
      print("dddddddddddddddddddd");
    }
  }
}


class SimpleIconDialogFatorah extends StatelessWidget {
  final Widget icon;
  final String title;
  final String body;
  const SimpleIconDialogFatorah({Key key, this.icon, this.title, this.body}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: size.width,
              margin: const EdgeInsets.only(left: 40,right: 40,top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Icon(Icons.close,color: MyTheme.mainAppColor,),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all( Colors.white),
                    shape: MaterialStateProperty.all(CircleBorder()),
                  ),),
                  Padding(
                    child:   Align(
                      child: Text(body,style: TextStyle(color: Colors.white),),
                      alignment: Alignment.center,
                    ),
                    padding: const EdgeInsets.only(bottom: 30,top: 20),
                  )
                ],
              ),
              padding: const EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 20),
              decoration: BoxDecoration(
                  color: MyTheme.mainAppColor,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: icon,
            )
          ],
        ),
      ),);
  }
}
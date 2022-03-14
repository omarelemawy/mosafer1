import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/bloc/state_drawer.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/model/mosafer_information_model.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:http/http.dart'as http;
import 'package:toast/toast.dart';

class DrawerCubit extends Cubit<DrawerState>{
  DrawerCubit() : super(InitialDrawerState());
  static DrawerCubit get(context) => BlocProvider.of(context);
  MosafrInformationModel mosafrInformationModel;
  List<FreeServiceModel> allFreeService=[];
  List<Widget> itemsOfInformFieldLocation=[];

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
  void getImage()
  {
    emit(CustomerServiceGetImageState());
  }
  void getgetMosafrInform()
  {
    getMosafrInformation().then((value) {
      mosafrInformationModel  = value;
    });
  }
  void getImageFirstDesign()
  {
    emit(CreateFreeServiceGetImageState());
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
  Future<GetAllRequestServicesModel> getAllFreeS () async {
    emit(GetLoadingFreeServiceModelStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/get-my-free-services");
    Map<String, String> mapData = {
      'authToken':CacheHelper.getData(key: "token")
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      emit(GetSuccessFreeServiceModelStates());
      return GetAllRequestServicesModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorFreeServiceModelStates(json['msg']));
    }

  }
  void getAllFreeService()
  {
    getAllFreeS().then((value) {
      allFreeService  = FreeServiceModel.toList(value.dataObj);
    });
  }
  void addItemLoc(Widget widget)
  {
    itemsOfInformFieldLocation.add(widget);
    emit(AddIteOfInformFreeServiceState());
  }

  Future createTrip (description,type,photo,places0,places1,places2,context) async {
    emit(CreateFreeServiceLoadingStates());

    Map<String, String> postBody = {
      "description": description,
      "type": type,
    };
    var APIURL = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/create-free-service");
    var request =  http.MultipartRequest("POST", APIURL);
    if(photo!=null) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
          'photo', photo.path);
      request.files.add(multipartFile);
    }
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    request.fields.addAll(postBody);
    request.headers.addAll(mapData);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      if (data["status"] == true) {
        print(value);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);

      emit(CreateFreeServiceSuccessStates());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(CreateFreeServiceErrorStates('msg'));
      }
    });
  /*  FormData formData;
    Map<String, dynamic> mapData1 = {
      "description": description,
      "type": type,
      "places[0][place]": places0,
      "places[1][place]": places1,
      "places[2][place]": places2,
    };
    print(mapData1);
    if(photo!=null){
      String fileName = photo.path.split('/').last;
      mapData1.addAll({
        "photo": await MultipartFile.fromFile(photo.path, filename:fileName),
      });
    }
    formData = FormData.fromMap(mapData1);
    print(formData);
    Response response;
    var dio = Dio();
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    response = await dio.post("https://msafr.we-work.pro/api/auth/masafr/create-free-service",
        data: mapData1,options: Options(headers:mapData ));
*/
  }
  Future<MosafrInformationModel> getMosafernformation ({int id}) async {
    emit(GetLoadingUserInformationStates());
    print(id);
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/user-info");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
      "Content-Type": "application/json; charset=UTF-8",
    };
    final response = await http.post(Api,headers: mapData,body: jsonEncode({
      "id"  : id
    }));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      mosafrInformationModel  =  MosafrInformationModel.fromJson(json);
      emit(GetSuccessUserInformationStates(MosafrInformationModel.fromJson(json)));
      print(response.body);
      return MosafrInformationModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      print(response.body);
      emit(GetErrorUserInformationStates(json['msg']));
    }
  }

  void getgetMosaferInform({int id})
  {
    getMosafernformation(id: id).then((value) {
      print("Val : ${value.data.name}");
      mosafrInformationModel  = value;
    });
  }
  Future deleteFreeService (id,context) async {
    emit(GetLoadingDeleteFreeServiceStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/delete-free-service");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData,body: {
      "id":id.toString()
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      getAllFreeService();
      Toast.show("تم مسح الخدمة", context,
          duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      emit(GetSuccessDeleteFreeServiceStates());
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorDeleteFreeServiceStates(json['msg']));
    }

  }
}
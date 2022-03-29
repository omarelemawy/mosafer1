import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/homeScreen.dart';
import 'package:mosafer1/login/bloc/state.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

import '../more_register_info.dart';
import '../verification_message.dart';


class LoginBloc extends Cubit<LoginStates>{
  LoginBloc() : super(InitialLoginStates());
  static LoginBloc get(context) => BlocProvider.of(context);
  bool valueSwitch = false;
  SingingCharacter character = SingingCharacter.Male;
  Future loginUser(context,email,pass) async {
    emit(LoginLoadingState());
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/masafr/login');
    Map mapData = {
      'phone': email,
      'password': pass,
    };
    http.Response response = await http.post(APIURL, body: mapData);
    var data = jsonDecode(response.body);
    if (data["status"] == true )
    {
      emit(LoginSuccessState());
      var token = data['msg']['token'];
      var id = data['msg']['id'];
      var name = data['msg']['name'];
      var photo = data['msg']['photo'];
      print("User : Token $token , id $id ");
      CacheHelper.saveData(key: 'token', value: token);
      CacheHelper.saveData(key: 'id', value: id);
      CacheHelper.saveData(key: 'name', value: name);
      CacheHelper.saveData(key: 'photo', value: photo);
      print("true");

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) =>
          HomeScreen()), (context) => false);
      return true;
    } else
    {
      print(response.body);
      emit(LoginErrorState("تأكد من ادخال رقم هاتف ورقم مرور صحيح"));
      return false;
    }
  }
  void getImage()
  {
    emit(RegisterGetImageState());
  }
  void getUserImage()
  {
    emit(RegisterGetUserImageState());
  }
  void getCarImage1()
  {
    emit(RegisterGetCar1ImageState());
  }
  void getCarImage2()
  {
    emit(RegisterGetCar2ImageState());
  }
  void getCarImage3()
  {
    emit(RegisterGetCar3ImageState());
  }
  void getImageNat()
  {
    emit(RegisterGetCar4ImageState());
  }
  void getImagePer()
  {
    emit(RegisterGetCar5ImageState());
  }
  changeSwitchValue(value)
  {
    valueSwitch=value;
    emit(ChangeSwitchValueState());
  }
  Future<http.StreamedResponse> uploadFile(filePath, context, name,
      email, phone, password,gender,country_code) async {
    emit(RegisterLoadingState());
    Map<String, String> postBody = {
      'email': email,
      'phone': phone,
      'name': name,
      'gender': gender,
      'password': password,
      'country_code':country_code
    };
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/masafr/create-account');
    var request =  http.MultipartRequest("POST", APIURL);
    http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'photo', filePath.path);
    print(postBody);
    request.files.add(multipartFile);
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var data = jsonDecode(value);
      if (data["status"] == true) {
        print(value);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:
            (context)=>VerificationMessage(data["masafr id"]))
            , (route) => false);
        emit(RegisterSuccessState());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(RegisterErrorState(data["msg"]));
      }
    });

    return response;
  }
  void changeGender(SingingCharacter value)
  {
    character = value;
    emit(ChangeGenderRegisterState());
  }
  Future<http.StreamedResponse> sendCode(id,context,code) async {

    emit(SendCodeLoadingState());
    Map<String, String> postBody = {
      "type" : "1",
      "id": id.toString(),
      "code" : code.toString()
    };
    print(postBody);
    var APIURL = Uri.parse('https://msafr.we-work.pro/api/masafr/varify-account');
    var request =  http.MultipartRequest("POST", APIURL);
    request.fields.addAll(postBody);
    http.StreamedResponse response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {

      var data = jsonDecode(value);
      print(data);
      if (data["status"] == true) {
        emit(SendCodeSuccessState());
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context)=>LoginScreen()),
                (route) => false);
      }
      else {
        data = jsonDecode(value);
        emit(SendCodeErrorState(data["msg"]));
      }
    });

    return response;
  }


  Future addMoreInformOfMosafer (id,national_id_number,nationality,car_name,car_model,car_number,
      id_photo,
      driving_license_photo,
      car_image_east,
      car_image_west,
      car_image_north,
      context) async
  {
    emit(AddMoreInformOfMosaferLoadingStates());

    Map<String, String> postBody = {
      "id": id.toString(),
      "national_id_number": national_id_number,
      "nationality": nationality,
      "car_name": car_name,
      "car_model": car_model,
      "car_number": car_number,
    };
    var APIURL = Uri.parse("https://msafr.we-work.pro/api/masafr/add-masafr-info");
    var request =  http.MultipartRequest("POST", APIURL);

      http.MultipartFile multipartFile = await http.MultipartFile.fromPath('id_photo', id_photo.path);
      http.MultipartFile multipartFile1 = await http.MultipartFile.fromPath('driving_license_photo', driving_license_photo.path);
      http.MultipartFile multipartFile2 = await http.MultipartFile.fromPath('car_image_east', car_image_east.path);
      http.MultipartFile multipartFile3 = await http.MultipartFile.fromPath('car_image_west', car_image_west.path);
      http.MultipartFile multipartFile4 = await http.MultipartFile.fromPath('car_image_north', car_image_north.path);

      request.files.add(multipartFile);
      request.files.add(multipartFile1);
      request.files.add(multipartFile2);
      request.files.add(multipartFile3);
      request.files.add(multipartFile4);

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

        emit(AddMoreInformOfMosaferSuccessStates());
      }
      else {
        print(response.statusCode);
        print(data["msg"]);
        emit(AddMoreInformOfMosaferErrorStates('msg'));
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
}
enum SingingCharacter { Male, FeMale }
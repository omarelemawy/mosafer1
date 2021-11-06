import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/home_nav/cubit/home_state.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:http/http.dart'as http;

class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(InitialHomeStates());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<RequestServices> allRequestsSe;
  Future<GetAllRequestServicesModel> getAllRequestSer () async {
      emit(GetLoadingAllRequestServicesStates());
      var Api = Uri.parse("https://msafr.we-work.pro/api/masafr/all-request-services");
      final response = await http.post(Api);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        emit(GetSuccessAllRequestServicesStates());
        print(response.body);
        return GetAllRequestServicesModel.fromJson(json);
      } else {
        final json = jsonDecode(response.body);
        print(response.body);
        emit(GetErrorAllRequestServicesStates(json['msg']));
      }

  }
  void getAllServices()
  {
    getAllRequestSer().then((value) {
      allRequestsSe  = value.data.requestServices;
    });
  }
}
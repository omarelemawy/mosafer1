import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:toast/toast.dart';

class MyTripsBloc extends Cubit<MyTripsStates>{
  MyTripsBloc() : super(InitialMyTripsStates());
  static MyTripsBloc get(context) => BlocProvider.of(context);
  List<Trips> allMyTrips;
  Future<GetMyTrips> getMyTrips () async {
    emit(GetLoadingAllMyRequestServicesStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/get-my-trips");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      emit(GetSuccessAllMyRequestServicesStates());

      return GetMyTrips.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorAllMyRequestServicesStates(json['msg']));
    }

  }
  void getMyTrip()
  {
    getMyTrips().then((value) {
      print(value);
      allMyTrips  = value.data.data;
    });
  }
  Future deleteTrip (id,context) async {
    emit(GetLoadingDeleteTripStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/delete-trip");
    Map<String, String> mapData = {
      'authToken': CacheHelper.getData(key: "token"),
    };
    final response = await http.post(Api,headers: mapData,body: {
         "id":id.toString()
          });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print(json);
      getMyTrip();
      Toast.show("تم مسح الرحله", context,
          duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
      emit(GetSuccessDeleteTripStates());
      return GetMyTrips.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorDeleteTripStates(json['msg']));
    }

  }
}
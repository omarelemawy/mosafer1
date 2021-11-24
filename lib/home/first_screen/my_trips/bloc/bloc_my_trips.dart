import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/model/get-my-trips.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

class MyTripsBloc extends Cubit<MyTripsStates>{
  MyTripsBloc() : super(InitialMyTripsStates());
  static MyTripsBloc get(context) => BlocProvider.of(context);
  List<Trips> allMyTrips;
  Future<GetMyTrips> getMyTrips () async {
    emit(GetLoadingAllMyRequestServicesStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/get-my-trips");
    Map<String, String> mapData = {
      'authToken': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbXNhZnIud2Utd29yay5wcm9cL2FwaVwvbWFzYWZyXC9sb2dpbiIsImlhdCI6MTYzNzc5MDA5MiwibmJmIjoxNjM3NzkwMDkyLCJqdGkiOiI4dmxyUHBTdEhRM2QxOGtjIiwic3ViIjoxLCJwcnYiOiI4ZjAyMzk3MWIxZDA3OTI2YmRhMDA3OWJlZWI5YTdkOTU0NGQyNTc1In0.vAaqei4zIJRiRKuHcJfhywP0K3mZo_7YQJSILQwBxK8',
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
}
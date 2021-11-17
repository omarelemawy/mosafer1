import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/home/first_screen/my_trips/bloc/state_my_trips.dart';


class MyTripsBloc extends Cubit<InitialMyTripsStates>{
  MyTripsBloc() : super(InitialMyTripsStates());


}
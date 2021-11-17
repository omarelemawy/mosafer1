import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/BottomNavigation/bloc/state_chat.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/model/all-request-services.dart';

class BottomNavigationBloc extends Cubit<BottomNaviagionStates> {
  BottomNavigationBloc() : super(EnabledState());
  static BottomNavigationBloc get(context) => BlocProvider.of(context);

  bool isEnabled = true;

  void toggleEnable(bool enable) => enable ? emit(EnabledState()) : emit(DisabledState());

}

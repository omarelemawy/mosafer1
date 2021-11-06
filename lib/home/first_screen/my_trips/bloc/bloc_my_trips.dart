import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';


class MyTripsBloc extends Cubit<ChatStates>{
  MyTripsBloc() : super(InitialChatStates());


}
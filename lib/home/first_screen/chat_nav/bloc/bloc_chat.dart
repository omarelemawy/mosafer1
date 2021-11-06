import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';


class ChatBloc extends Cubit<ChatStates>{
  ChatBloc() : super(InitialChatStates());


}
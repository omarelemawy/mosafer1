
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';

class ChatBloc extends Cubit<ChatStates> {

  ChatBloc() : super(LoadingChatStates());
  ChatData _chatData = ChatData();
  final ImagePicker _picker = ImagePicker();

  static ChatBloc get(context) => BlocProvider.of(context);
  List<Message> messages = [];
  List<ChatRoom> chatRooms = [];
  String imagePath = "";
  void getMessages(var chatRoomId){
    _chatData.chatRoomStream(chatRoomId).listen((messageData) {
      List<Message> msgList = Message.toList(messageData);
      messages = msgList;
      print("Messages : ${messageData}");
      if(messages.isNotEmpty){
        emit(LoadedChatStates(messages));
      }else{
        emit(NoMessageChatStates());
      }
    });
    print("Loading");
  }

  void sendMessage(Message message,ScrollController scrollController) {
    messages.add(message);
    emit(NewMessage(messages));
    //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
  }

  Future<List<ChatRoom>> getChatRooms(int userId) async {
    //GetAllRequestServicesModel requestServicesModel = await _chatData.getChatRooms(1);
    //chatRooms = ChatRoom.toList(requestServicesModel.dataObj);
    return _chatData.getChatRooms(1);
  }

  void selectAndGetImagePath({bool isCamera = false}) async {
    final XFile image = await _picker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    imagePath = image != null ? image.path : "";
    emit(NewImageState());
  }

}

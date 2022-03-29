
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosafer1/Complaint/ComplaintsPage.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/request_service_from_chat.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/Firebase/Chat.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:http/http.dart'as http;
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';

class ChatBloc extends Cubit<ChatStates> {

  ChatBloc() : super(LoadingChatStates());
  ChatData _chatData = ChatData();
  final ImagePicker _picker = ImagePicker();
  HttpOps _httpOps = HttpOps();
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
  Future<String> createNegotiationRequest({int request_id,int chat_id}) async {
    var data = {
      "request_id":request_id,
      "chat_id":chat_id
    };

    GetAllRequestServicesModel responseModel = await _httpOps.postData(endPoint: negotiationUrl,auth: true , mapData: data);
    print("Msg : ${responseModel.dataObj["subject"]}");
    if(responseModel.status){
      return responseModel.dataObj["subject"];
    }else{
      return "";
    }
  }
  void sendMessage(Message message,ScrollController scrollController) {
    messages.add(message);
    emit(NewMessage(messages));
    //scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
  }

  Future<List<ChatRoom>> getChatRooms(int userId) async {
    //GetAllRequestServicesModel requestServicesModel = await _chatData.getChatRooms(1);
    //chatRooms = ChatRoom.toList(requestServicesModel.dataObj);
    return _chatData.getChatRooms(userId);
  }

  void selectAndGetImagePath({bool isCamera = false}) async {
    final XFile image = await _picker.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    imagePath = image != null ? image.path : "";
    emit(NewImageState());
  }
  RequestServices allRequestsSe;
  Future<GetAllRequestServicesModel> getChatRequestSer (context,id,chatRoomsid) async {
    emit(GetLoadingChatRequestServicesStates());
    var Api = Uri.parse("https://msafr.we-work.pro/api/auth/masafr/get-request-service");
    final response = await http.post(Api,body: {
      "request_id":id.toString()
    },headers: { "authToken": CacheHelper.getData(key: "token") } );
    if (response.statusCode == 200) {
      print(response.body);
      final json = jsonDecode(response.body);
      emit(GetSuccessChatRequestServicesStates());
      return GetAllRequestServicesModel.fromJson(json);
    } else {
      final json = jsonDecode(response.body);
      emit(GetErrorChatRequestServicesStates(json['msg']));
    }

  }
  void getChatServices(context,id,chatRoomsid)
  {
    getChatRequestSer(context,id,chatRoomsid).then((value) {
      allRequestsSe  = RequestServices.fromJson(value.dataObj);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          RequestServiceFromChatPage(requestServices: allRequestsSe,chatRoomsid: chatRoomsid,)));
    });
  }
  Future<String> createComplaint({int chat_id,context}) async {
    var data = {
      "subject": "he take money5 from me i'am user",
      "chat_id":chat_id.toString(),
    };
    GetAllRequestServicesModel responseModel = await _httpOps.postData(endPoint:
    CreateComplaintsRoomUrl,auth: true , mapData: data);
    print("Msg : ${responseModel.dataObj}");
    if(responseModel.status){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintesPage()));
      return responseModel.dataObj["msg"];
    }else{
      return "";
    }
  }

}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/netWork/Api.dart';
import 'package:mosafer1/shared/netWork/end_point.dart';
import 'package:uuid/uuid.dart';

class ChatData {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  HttpOps _httpOps = HttpOps();
  Stream<QuerySnapshot> chatRoomStream(var chatRoomId) => _firestore.collection("ChatRooms/$chatRoomId/Messages").orderBy("time",descending: false).snapshots();

  Future sendMessage({var chatRoomId , Message message,bool isComplaint = false}) async {
    String imgUrl = "";
    if(message.messageImage.isNotEmpty) {
      var uuid = Uuid().v1();
      Reference ref = storage.ref(
          isComplaint ? 'complaintsRef/$chatRoomId/$uuid.jpg' : '$chatRoomId/$uuid.jpg'
      );
      TaskSnapshot taskSnapshot = await ref.putFile(File(message.messageImage)) ;
      imgUrl = await taskSnapshot.ref.getDownloadURL();
    }
    message.messageImage = imgUrl;
    await _firestore.collection(
        isComplaint ? "ComplaintChatRooms/$chatRoomId/Messages" : "ChatRooms/$chatRoomId/Messages"
    ).add(message.toMap());
    print("Sent");
  }

  Future<List<ChatRoom>> getChatRooms(int userId) async {
    Map data = {};
    GetAllRequestServicesModel responseModel = await _httpOps.postData(endPoint: getChatRoomsUrl,auth: true , mapData: data);
    print("Response $responseModel");
    print(responseModel);
    return ChatRoom.toList(responseModel.dataObj['data']);
  }
  Stream<QuerySnapshot> complainChatRoomStream(var chatRoomId) =>
      _firestore.collection("ComplaintChatRooms/$chatRoomId/Messages").orderBy("time",descending: false).snapshots();
  Future<int> getOrCreateChatRoom(int masafrId,int userId,related_trip) async {

    Map data  = {
      "user_id" : userId.toString(),
      "masafr_id" : masafrId.toString(),
      "related_request_service":related_trip.toString()
    };
     print(data);
    GetAllRequestServicesModel responseModel = await _httpOps.postData(endPoint: createChatRoom,
        auth: true , mapData: data);
    return responseModel.dataObj != null ? responseModel.dataObj as int : 0;

  }
}
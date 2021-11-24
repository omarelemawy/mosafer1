import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

class GetAllRequestServicesModel {
  bool status;
  String errNum;
  String msg;
  var data;
  var dataObj;
  GetAllRequestServicesModel({this.status, this.errNum, this.msg, this.data});

  GetAllRequestServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    try{
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    }catch(e){
      print("Data not valid");
    }
    dataObj = json['data'] != null ? json['data'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}

class Data {
  int currentPage;
  List<RequestServices> requestServices;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Links> links;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  Data(
      {this.currentPage,
        this.requestServices,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      requestServices = new List<RequestServices>();
      json['data'].forEach((v) {
        requestServices.add(new RequestServices.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.requestServices != null) {
      data['data'] = this.requestServices.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class RequestServices {
  int id;
  String userId;
  String typeOfTrips;
  String typeOfServices;
  String fromPlace;
  String fromLongitude;
  String fromLatitude;
  String toPlace;
  String toLongitude;
  String toLatitude;
  String maxDay;
  String deliveryTo;
  String photo;
  String description;
  String onlyWomen;
  String haveInsurance;
  String insuranceValue;
  String websiteService;
  String numberOfPassengers;
  String typeOfCar;
  String active;
  String createdAt;
  String updatedAt;
  String negotiation;
  User user;
  Service service;

  RequestServices(
      {this.id,
        this.userId,
        this.typeOfTrips,
        this.typeOfServices,
        this.fromPlace,
        this.fromLongitude,
        this.fromLatitude,
        this.toPlace,
        this.toLongitude,
        this.toLatitude,
        this.maxDay,
        this.deliveryTo,
        this.photo,
        this.description,
        this.onlyWomen,
        this.haveInsurance,
        this.insuranceValue,
        this.websiteService,
        this.numberOfPassengers,
        this.typeOfCar,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.negotiation,
        this.user,
        this.service});

  RequestServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    typeOfTrips = json['type_of_trips'];
    typeOfServices = json['type_of_services'];
    fromPlace = json['from_place'];
    fromLongitude = json['from_longitude'];
    fromLatitude = json['from_latitude'];
    toPlace = json['to_place'];
    toLongitude = json['to_longitude'];
    toLatitude = json['to_latitude'];
    maxDay = json['max_day'];
    deliveryTo = json['delivery_to'];
    photo = json['photo'];
    description = json['description'];
    onlyWomen = json['only_women'];
    haveInsurance = json['have_insurance'];
    insuranceValue = json['insurance_value'];
    websiteService = json['website_service'];
    numberOfPassengers = json['number_of_passengers'];
    typeOfCar = json['type_of_car'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    negotiation = json['negotiation'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type_of_trips'] = this.typeOfTrips;
    data['type_of_services'] = this.typeOfServices;
    data['from_place'] = this.fromPlace;
    data['from_longitude'] = this.fromLongitude;
    data['from_latitude'] = this.fromLatitude;
    data['to_place'] = this.toPlace;
    data['to_longitude'] = this.toLongitude;
    data['to_latitude'] = this.toLatitude;
    data['max_day'] = this.maxDay;
    data['delivery_to'] = this.deliveryTo;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['only_women'] = this.onlyWomen;
    data['have_insurance'] = this.haveInsurance;
    data['insurance_value'] = this.insuranceValue;
    data['website_service'] = this.websiteService;
    data['number_of_passengers'] = this.numberOfPassengers;
    data['type_of_car'] = this.typeOfCar;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['negotiation'] = this.negotiation;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String photo;
  String rate;
  String idPhoto;
  String nationality;
  String nationalIdNumber;
  String gender;
  String email;
  String countryCode;
  String phone;
  String verificationCode;
  String activeTry;
  String emailVerifiedAt;
  String isVerified;
  String lastTryVerify;
  String lastSendVerifyCode;
  String emailNotifications;
  String balance;
  String trust;
  String decisionMaker;
  String createdAt;
  String updatedAt;

  User(
      {this.id,
        this.name,
        this.photo,
        this.rate,
        this.idPhoto,
        this.nationality,
        this.nationalIdNumber,
        this.gender,
        this.email,
        this.countryCode,
        this.phone,
        this.verificationCode,
        this.activeTry,
        this.emailVerifiedAt,
        this.isVerified,
        this.lastTryVerify,
        this.lastSendVerifyCode,
        this.emailNotifications,
        this.balance,
        this.trust,
        this.decisionMaker,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    rate = json['rate'];
    idPhoto = json['id_photo'];
    nationality = json['nationality'];
    nationalIdNumber = json['national_id_number'];
    gender = json['gender'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    verificationCode = json['verification_code'];
    activeTry = json['active_try'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['is_verified'];
    lastTryVerify = json['last_try_verify'];
    lastSendVerifyCode = json['last_send_verify_code'];
    emailNotifications = json['email_notifications'];
    balance = json['balance'];
    trust = json['trust'];
    decisionMaker = json['decision_maker'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  User.forChat(this.id, this.name, this.photo, this.idPhoto, this.email);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['rate'] = this.rate;
    data['id_photo'] = this.idPhoto;
    data['nationality'] = this.nationality;
    data['national_id_number'] = this.nationalIdNumber;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['verification_code'] = this.verificationCode;
    data['active_try'] = this.activeTry;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_verified'] = this.isVerified;
    data['last_try_verify'] = this.lastTryVerify;
    data['last_send_verify_code'] = this.lastSendVerifyCode;
    data['email_notifications'] = this.emailNotifications;
    data['balance'] = this.balance;
    data['trust'] = this.trust;
    data['decision_maker'] = this.decisionMaker;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Service {
  int id;
  String categorieName;
  String photo;
  String title;
  String onlySaudi;
  String paymentMethod;
  String haveInsurance;
  String havePhoto;
  String twoPlaces;
  String twoCodes;
  String active;
  String createdAt;
  String updatedAt;

  Service(
      {this.id,
        this.categorieName,
        this.photo,
        this.title,
        this.onlySaudi,
        this.paymentMethod,
        this.haveInsurance,
        this.havePhoto,
        this.twoPlaces,
        this.twoCodes,
        this.active,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categorieName = json['categorie_name'];
    photo = json['photo'];
    title = json['title'];
    onlySaudi = json['only_saudi'];
    paymentMethod = json['payment_method'];
    haveInsurance = json['have_insurance'];
    havePhoto = json['have_photo'];
    twoPlaces = json['two_places'];
    twoCodes = json['two_codes'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categorie_name'] = this.categorieName;
    data['photo'] = this.photo;
    data['title'] = this.title;
    data['only_saudi'] = this.onlySaudi;
    data['payment_method'] = this.paymentMethod;
    data['have_insurance'] = this.haveInsurance;
    data['have_photo'] = this.havePhoto;
    data['two_places'] = this.twoPlaces;
    data['two_codes'] = this.twoCodes;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String url;
  String label;
  bool active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}

class Message {
  String message;
  String messageImage;
  GeoPoint messageLocation;
  User user;
  MessageType messageType;
  bool isCurrentUser;
  String time;
  bool seen;

  Message({this.message, this.messageImage,this.messageType,this.user, this.isCurrentUser,this.time,this.seen,this.messageLocation});

  factory Message.fromMap(QueryDocumentSnapshot map) {
    return Message(
        seen: map["seen"],
        time: timeago.format(map["time"].toDate()),
        message: map["messageText"],
        messageLocation: map['messageLocation'] != null ? map['messageLocation']  : null,
        messageImage: map["messageImage"],
        messageType: _getMessageType(map["messageType "]),
        isCurrentUser: map["userInfo"]["userId"] == CacheHelper.getData(key: "id"),
        user: User.forChat(
            map["userInfo"]["userId"],
            map["userInfo"]["userName"],
            map["userInfo"]["image"],
            map["userInfo"]["image"],
            map["userInfo"]["image"])
    );
  }

  static List<Message> toList(QuerySnapshot data) => data.docs.map((chatMap) => Message.fromMap(chatMap)).toList();

  Map<String, dynamic> toMap(){
    return {
      "messageText" : message,
      "messageImage" : messageImage,
      "messageLocation" : messageLocation,
      "time" : Timestamp.now(),
      "seen" : false,
      "messageType " : _getMessageTypeString(),
      "userInfo" : {
        "userName" : user.name,
        "image" : user.photo,
        "userId" : user.id,
      }
    };
  }

  String _getMessageTypeString() {
    if(messageType != null){
      return messageType.stringify();
    }else{
      if(messageImage.isNotEmpty && message.isEmpty) {
        return "ImageMessage";
      }else if(messageImage.isNotEmpty && message.isNotEmpty){
        return "ImageMessage";
      } else if(messageImage.isEmpty && message.isEmpty){
        return "MapMessage";
      }
    }
    return "TextMessage";
  }
  static MessageType _getMessageType(String type) {
    print(MessageType.values[0].toString().split('.').last);
    return MessageType.values.firstWhere((element) => element.toString().split('.').last == type);
  }
}

class Notifications {
  int id;
  String title;
  String subject;
  String time;
  String type;
  bool seen;
  Notifications({this.id, this.title, this.subject, this.time, this.type,this.seen});

  factory Notifications.fromMap(Map map) {
    return Notifications(
        seen : false,
        time: timeago.format(DateTime.parse(map["created_at"])),
        id: map["id"],
        subject: map["subject"],
        title: map["title"],
        type: map["type"]
    );
  }

  static List<Notifications> toList(List data) => data.map((map) => Notifications.fromMap(map)).toList();
}
class ChatRoom {
  int id;
  Message lastMessage;
  User mosafer;
  User client;

  ChatRoom({this.id, this.lastMessage,this.mosafer,this.client,});

  factory ChatRoom.fromMap(Map map) {
    return ChatRoom(
      id: map["id"],
      lastMessage: Message(message: "",user: User.forChat(1, "name", "photo", "idPhoto", "email")),
      client: User.fromJson(map["user"]),
    );
  }

  static List<ChatRoom> toList(List data) => data.map((chatRoomMap) => ChatRoom.fromMap(chatRoomMap)).toList();
}

class FatorahService {
  String serviceName;
  String servicePrice;
  FatorahService(this.serviceName, this.servicePrice);
}

enum MessageType {
  TextMessage,
  ImageMessage,
  TextImageMessage,
  MapMessage,
  Complaint,
  Reset,
}

extension ToString on MessageType {
  String stringify(){
    switch(this){
      case MessageType.Reset : return 'Reset';
      case MessageType.TextMessage : return 'TextMessage';
      case MessageType.ImageMessage: return 'ImageMessage';
      case MessageType.TextImageMessage: return 'TextImageMessage';
      case MessageType.MapMessage: return 'MapMessage';
      case MessageType.Complaint: return 'Complaint';
    }
    return "TextMessage";
  }
}
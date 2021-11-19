import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/chat_nav/ChatItem.dart';
import 'package:mosafer1/home/first_screen/chat_nav/MessengerPage/ChatMessengerScreen.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/bloc_chat.dart';
import 'package:mosafer1/model/all-request-services.dart';


class ChatNav extends StatefulWidget {
  BuildContext context1;
   ChatNav(this.context1);
  @override
  _ChatNavState createState() => _ChatNavState();
}

class _ChatNavState extends State<ChatNav> {
  ChatBloc chatBloc;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.getChatRooms(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: FutureBuilder<List<ChatRoom>>(
            future: chatBloc.getChatRooms(1),
            builder: (context,snap){
              print("Snap : ${snap}");
              if(snap.hasData) {
                print("Snap data: ${snap.data}");
                return ListView.separated(
                  itemCount: snap.data.length,
                  itemBuilder: (context1,index) => ChatListItem(chatRoom: snap.data[index],onItemClick: () {
                    Navigator.push(context1, MaterialPageRoute(builder: (context1)=> ChatMessengerScreen()));
                  },),
                  separatorBuilder: (context,index) => Divider(endIndent: 10,indent: 10,color: Colors.grey,),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

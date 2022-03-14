import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/drawer/drawer.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/bloc_notifi.dart';
import 'package:mosafer1/home/first_screen/notifi_nav/bloc/state_notifi.dart';
import 'package:mosafer1/login/login.dart';
import 'package:mosafer1/shared/netWork/local/cache_helper.dart';


class NotifiNav extends StatefulWidget {
  BuildContext context1;
   NotifiNav(this.context1);

  @override
  _NotifiNavState createState() => _NotifiNavState();
}

class _NotifiNavState extends State<NotifiNav> {
  NotifiBloc notifiBloc;
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifiBloc = BlocProvider.of<NotifiBloc>(context);
      notifiBloc.getAllNotifications(1);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CacheHelper.getData(key: "token")==null?
    Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Go To Sing In First",style: TextStyle(color: HexColor("#A2B594"),
                fontSize: 15,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            MaterialButton(
              color: HexColor("#A2B594"),
              onPressed: (){
                /* pushNewScreen(
                        context,
                        screen: LoginScreen(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.scale,
                      );*/
                Navigator.pushAndRemoveUntil(widget.context1, MaterialPageRoute(builder: (context1)=>LoginScreen())
                    , (route) => false);
              },
              child: Text("Go",style: TextStyle(color: Colors.white
              ),),
            )
          ],
        ),
      ),
    ):Scaffold(
      body: Center(
        child: BlocConsumer<NotifiBloc,NotifiStates>(
          builder: (context,state){
            print(state);
            if(state is LoadingNotifications) {
              return Center(child: CircularProgressIndicator(),);
            }else if(state is LoadedNotifications) {
              return ListView.separated(
                itemCount: notifiBloc.notifications.length,
                itemBuilder: (context,index) => ListTile(
                  title: Text(notifiBloc.notifications[index].title),
                  subtitle: Text(notifiBloc.notifications[index].subject,style: TextStyle(color: Colors.black),),
                  trailing: Text(notifiBloc.notifications[index].time),
                ),
                separatorBuilder: (context,index)=> Divider(indent: 10,endIndent: 10,),
              );
            }
            return CircularProgressIndicator();
          },
          listener: (context,state){},
        ),
      ),
    );
  }
}

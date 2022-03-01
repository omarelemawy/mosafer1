import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:marquee/marquee.dart';
import 'package:mosafer1/home/first_screen/my_trips/my_trips_nav.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'BottomNavigation/bloc/bloc_chat.dart';
import 'BottomNavigation/bloc/state_chat.dart';
import 'first_screen/add_trip_nav/add_trip.dart';
import 'first_screen/chat_nav/chat_nav.dart';
import 'drawer/drawer.dart';
import 'first_screen/home_nav/home_nav.dart';
import 'first_screen/notifi_nav/notifi_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PersistentTabController _controller= PersistentTabController(initialIndex: 2);
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final Size size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) =>
            BottomNavigationBloc(),
        child: Scaffold(
            drawer: MyDrawer(),
            appBar: AppBar(
              title: BlocConsumer<BottomNavigationBloc, BottomNaviagionStates>(
                 builder: (context,state){
                   return Text(BottomNavigationBloc
                       .get(context)
                       .appTitle, style: TextStyle(fontFamily: "beIN"
                     , color: Colors.white,),
                   );
                 }, listener: (BuildContext context, state) { },
              ),
              centerTitle: true,
              bottom: PreferredSize(child:
              BlocProvider(
                  create: (context) =>
                  BottomNavigationBloc()
                    ..getAdvertisings(),
                  child: BlocConsumer<BottomNavigationBloc,
                      BottomNaviagionStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Container(
                        child: state is LoadedAddState ? Column(
                          children: [
                            Container(
                              height: 45,
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 2, top: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    "اذهب الي الاعلان",
                                    style: appTheme.textTheme.overline,
                                  ),
                                  TextButton(onPressed: () {
                                    _launchURL(state.addList[0].link);
                                  }, child: Text("اذهب"),

                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: size.width,
                                height: 40,
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 2, top: 2),
                                child: Marquee(
                                  text: state.addList[0].subject +
                                      "                            ",
                                  style: appTheme.textTheme.bodyText1,
                                  velocity: 20.0,
                                ))
                          ],
                        ) : CircularProgressIndicator(),);
                    },)
              )
                , preferredSize: Size.fromHeight(90),
              ),
            ),
            body: BlocConsumer<BottomNavigationBloc, BottomNaviagionStates>(
              builder: (context, state) {
                return PersistentTabView(
                  context,
                  onItemSelected: (g) {
                    print("1");
                    switch (g) {
                      case 4:
                        BottomNavigationBloc
                            .get(context).changeNavegat("الاشعارات");
                        break;
                      case 3:
                        BottomNavigationBloc.get(context).changeNavegat(
                            " رحلاتي ");
                        break;
                      case 2:
                        BottomNavigationBloc.get(context).changeNavegat(
                            "الصفحه الرئيسية ");
                        break;
                      case 1:
                        BottomNavigationBloc.get(context).changeNavegat(
                            "أضافة رحله");
                        break;
                      case 0:
                        BottomNavigationBloc.get(context).changeNavegat(
                            "محادثات ");
                        break;
                    }
                  },
                  controller: _controller,
                  screens: _buildScreens(context),
                  items: _navBarsItems(),
                  confineInSafeArea: true,
                  backgroundColor: HexColor("#9EB28F"),
                  // Default is Colors.white.
                  handleAndroidBackButtonPress: true,
                  // Default is true.
                  resizeToAvoidBottomInset: true,
                  // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                  stateManagement: true,
                  // Default is true.
                  hideNavigationBarWhenKeyboardShows: true,
                  // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                  popAllScreensOnTapOfSelectedTab: true,
                  popActionScreens: PopActionScreensType.all,
                  itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  ),
                  screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                    animateTabTransition: true,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 200),
                  ),
                  decoration: NavBarDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))
                  ),
                  navBarStyle: NavBarStyle
                      .style1, // Choose the nav bar style with this property.
                );
              },
              listener:(context,state){} ,
            )
        ),
      ),
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.chat_bubble),
        title: ("المحادثات"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/add_car.png"),
        title: ("رحلاتي"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("الرئيسية"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/add_car1.png"),
        title: ("أضافة رحله"),
        activeColorPrimary:Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Badge(
            badgeContent: Text(''),
            child: Icon(Icons.notifications)
        ),
        title: ("الاشعارات"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];

  }
  List<Widget> _buildScreens(context) {
    return [
      ChatNav(context),
      MyTripsNav(context),
      HomeNav(context),
      AddTrip(context),
      NotifiNav(context),
    ];
  }
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}

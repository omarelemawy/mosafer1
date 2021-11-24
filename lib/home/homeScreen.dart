import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/home/BottomNavigation/bloc/bloc_chat.dart';
import 'package:mosafer1/home/first_screen/my_trips/my_trips_nav.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'BottomNavigation/bloc/state_chat.dart';
import 'first_screen/Search/SearchPage.dart';
import 'first_screen/add_trip_nav/add_trip.dart';
import 'first_screen/chat_nav/chat_nav.dart';
import 'drawer/drawer.dart';
import 'first_screen/home_nav/home_nav.dart';
import 'first_screen/notifi_nav/notifi_nav.dart';

class HomeScreen extends StatefulWidget {

  static GlobalKey<ScaffoldState> scaffKey = GlobalKey();

  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  PersistentTabController _controller= PersistentTabController(initialIndex: 2);
  BottomNavigationBloc bottomNavigationBloc;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bottomNavigationBloc = BlocProvider.of<BottomNavigationBloc>(context,);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeScreen.scaffKey,
      drawer: MyDrawer(),
      body: BlocConsumer<BottomNavigationBloc, BottomNaviagionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            hideNavigationBar: state is EnabledState ? false : true,
            backgroundColor: MyTheme.mainAppBlueColor, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) )
            ),
            navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
          );
        },
      ),
    );
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Stack(
          alignment: Alignment.centerRight,
          children: [
            Icon(CupertinoIcons.chat_bubble),
            Container(
              width: 15,
              height: 15,
              alignment: Alignment.center,
              child: FittedBox(child: Text("12",style: TextStyle(fontSize: 14,color: Colors.white),)),
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
            )
          ],
        ),
        title: ("المحادثات"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.work),
        title: ("طلباتي"),
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
        icon: Icon(Icons.search,color: Colors.white,),
        title: ("ابحث"),
        activeColorPrimary:Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          alignment: Alignment.centerRight,
          children: [
            Icon(Icons.notifications),
            Container(
              width: 15,
              height: 15,
              alignment: Alignment.center,
              child: FittedBox(child: Text("12",style: TextStyle(fontSize: 14,color: Colors.white),)),
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle
              ),
            )
          ],
        ),
        title: ("الاشعارات"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];

  }
  List<Widget> _buildScreens() {
    return [
      ChatNav(context),
      MyTripsNav(context),
      HomeNav(context),
      SearchPage(),
      NotifiNav(context),
    ];
  }
}


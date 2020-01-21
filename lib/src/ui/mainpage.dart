import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siplah_jpmall/src/ui/page_carts.dart';
import 'package:siplah_jpmall/src/ui/page_feeds.dart';
import 'package:siplah_jpmall/src/ui/page_home.dart';
import 'package:siplah_jpmall/src/ui/page_officialstore.dart';
import 'package:siplah_jpmall/src/ui/page_profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double posisi = 0.0;
  int currentPage = 0;
  ScrollController _controller;
  _scrollListener() {
    // if (_controller.offset >= _controller.position.maxScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     message = "reach the bottom";
    //   });
    //     // print("reach the bottom");
    // }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     message = "reach the top";
    //   });
    //     // print("reach the top");
    // }
    setState(() {
      posisi = _controller.offset;
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color(0xFF6BB8E3), //top bar color
          statusBarIconBrightness: Brightness.light, //top bar icons
          systemNavigationBarColor: Colors.white, //bottom bar color
          systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
        )
    );
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }
  final _page = [
    HomePage(),
       CartsPage(),
     FeedsPage(),
    ProfilePage()
  ];

  void _tabItem(int index) {
    setState(() {
      currentPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   body: CustomScrollView(
      //     controller: _controller,
      //     slivers: <Widget>[
      //       SliverAppBar(
      //         title: AnimatedCrossFade(
      //           duration: const Duration(milliseconds: 200),
      //           firstChild: MyAppBarNormal(),
      //           secondChild: MyAppBarAbNormal(),
      //           crossFadeState: posisi <= 27
      //               ? CrossFadeState.showFirst
      //               : CrossFadeState.showSecond,
      //               firstCurve: Curves.bounceIn,
      //               secondCurve: Curves.bounceInOut
      //         ),
      //         // title: AnimatedContainer(
      //         //   duration: Duration(seconds: 3),
      //         //   curve: Curves.decelerate,
      //         //   child: _controller.offset <= 27 ? MyAppBarNormal() : MyAppBarAbNormal()
      //         // ),
      //         // title: Transform.scale(
      //         //   scale: 12.0,
      //         //   child: posisi >= 27 ? MyAppBarNormal() : MyAppBarAbNormal()),
      //         pinned: true,
      //         expandedHeight: 120,
      //         flexibleSpace: FlexibleSpaceBar(
      //           background: MyFlexSpace(),
      //         ),
      //       ),
      //       SliverList(
      //         delegate: SliverChildListDelegate(<Widget>[
      // Column(
      //   children: <Widget>[
      //     SizedBox(height: 10,),
      //     ImageSlider(),
      //     SizedBox(height: 10,),
      //     FlashDeal(),
      //     SizedBox(height: 10,),
      //     Column(
      //       children: List.generate(50, (p){
      //         return ListTile(
      //           title: Text("Item Count $p"),
      //         );
      //       }),
      //     ),
      //     SizedBox(height: 10,),
      //   ]
      // )
      // ]),
      // )
      //     ],
      //   ),
      body: _page.elementAt(currentPage),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: _tabItem,
            fixedColor: Colors.purple,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                // backgroundColor: 
                title: Text("home", style: TextStyle(fontSize: 12),),
                icon: Icon(Icons.home)
              ),
               BottomNavigationBarItem(
                title: Text("Carts", style: TextStyle(fontSize: 12),),
                icon: Icon(Icons.shopping_cart,)
              ),
              // BottomNavigationBarItem(
              //   title: Text("Official Store", style: TextStyle(fontSize: 12),),
              //   icon: Icon(Icons.store_mall_directory,)
              // ),
            
               BottomNavigationBarItem(
                title: Text("Mitra", style: TextStyle(fontSize: 12),),
                icon: Icon(Icons.group,)
              ),
              BottomNavigationBarItem(
                title: Text("Profile", style: TextStyle(fontSize: 12),),
                icon: Icon(Icons.account_circle,)
              ),
            ],
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:raudio_app/view/messages/messages_view.dart';
import 'package:raudio_app/view/profile/my_profile_view.dart';
import 'package:raudio_app/view/discover/discover_page_view.dart';

class TabView extends StatefulWidget {
  static const String id = 'tab_screen';
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(66.0), // here the desired height
          child: new AppBar(
            backgroundColor: Colors.black12,
            bottom: TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.grey,
              tabs: [
                Tab(
                    icon: Icon(
                  Icons.account_circle,
                  size: 40.0,
                )),
                Tab(
                  icon: ImageIcon(AssetImage('images/logo.png'), size: 40.0),
                ),
                Tab(
                  icon: Icon(Icons.mode_comment, size: 40.0),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            MyProfilePage(),
            DiscoverPage(),
            Messages(),
          ],
        ),
      ),
    );
  }
}

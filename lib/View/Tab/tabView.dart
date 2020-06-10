import 'package:flutter/material.dart';
import 'package:raudio_app/View/Messages/messagesView.dart';
import 'package:raudio_app/View/Profile/myProfileView.dart';
import 'package:raudio_app/View/Discover/discoverPageView.dart';

class TabView extends StatefulWidget {
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

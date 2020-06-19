import 'package:flutter/material.dart';
import 'listening_now_view.dart';
import 'discover_card_view.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListeningNow(),
        DiscoverList(),
      ],
    );
  }
}

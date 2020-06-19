import 'package:flutter/material.dart';
import 'package:raudio_app/controller/profile/my_profile_controller.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  MyProfileController con = MyProfileController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 300,
          width: double.infinity,
          child: FittedBox(
            child: Image.network(con.image()),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        Text(
          con.name(),
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 10,
          width: 10,
        ),
        Text(
          'location: ${con.location()}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: 200),
      ],
    );
  }
}

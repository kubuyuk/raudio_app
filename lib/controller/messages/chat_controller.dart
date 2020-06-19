import 'package:raudio_app/model/mock_user_data.dart';

class ChatController {
  String name({int userID}) {
    //TODO: Control userid and return name form the databse
    return mockUserList[userID].name;
  }
}

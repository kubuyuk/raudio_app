import 'package:raudio_app/model/mock_data/mock_user_data.dart';

class ProfileController {
  int userUri;
  ProfileController(this.userUri);

  String name() {
    return mockUserList[userUri].name; //TODO: get users from Firebase
  }

  String ppURL() {
    return mockUserList[userUri].ppURL; //TODO: get users from Firebase
  }
}

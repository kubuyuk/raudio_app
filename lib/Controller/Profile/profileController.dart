import 'package:raudio_app/Model/MockData/mockUserData.dart';

class ProfileController {
  int userUri;
  ProfileController(this.userUri);

  String name() {
    return mockUserList[userUri].name;
  }

  String ppURL() {
    return mockUserList[userUri].ppURL;
  }
}

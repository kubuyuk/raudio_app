import 'file:///C:/Users/Admin/AndroidStudioProjects/raudio_app/lib/model/mock_user_data.dart';

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

import 'package:my_utils/storage_repository.dart';

class Checker {
  static void checkRemoteData({required remoteData}) {
    String localData = StorageRepository.getString(key: "currencies");
    if (remoteData != localData) {
      StorageRepository.setString(key: "currencies", value: remoteData);
      print("saved");
    } else {
      print("No changes");
    }
  }

  static String getLocalData() {
    String localData = StorageRepository.getString(key: "currencies");

    if (localData.isNotEmpty) {
      return localData;
    }
    return "";
  }
}

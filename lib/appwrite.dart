import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AppwriteService extends GetxService {
  late Client client;
  late Account account;
  late Storage storage;
  late TablesDB tables;

  Future<AppwriteService> init() async {
    client = Client()
        .setEndpoint("https://fra.cloud.appwrite.io/v1")
        .setProject("68ad367b00104ab260d9");

    account = Account(client);
    storage = Storage(client);
    tables = TablesDB(client);

    return this;
  }
}


class AppwriteUserCredential {
  final models.Session session;
  final models.User user;

  AppwriteUserCredential({
    required this.session,
    required this.user,
  });
}


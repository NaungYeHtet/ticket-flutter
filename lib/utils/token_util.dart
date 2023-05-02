import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenUtil {
  final storage = const FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    print('STORING TOKEN >>>>>');
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    print('GETTING TOKEN >>>>>');
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    print('DELETING TOKEN >>>>>');
    await storage.delete(key: 'token');
  }
}

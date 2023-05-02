import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PusherService {
  Future<void> initPusher(String channelName) async {
    await Future.delayed(const Duration(seconds: 1));
    PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
    try {
      final apiKey = dotenv.env['PUSHER_API_KEY'];
      final apiCluster = dotenv.env['PUSHER_API_CLUSTER'];
      print("PUSHER_API_KEY >>>>>>>>> $apiKey");
      print("PUSHER_API_CLUSTER >>>>>>>>> $apiCluster");
      await pusher.init(
        apiKey: dotenv.env['PUSHER_API_KEY']!,
        cluster: dotenv.env['PUSHER_API_CLUSTER']!,
      );
      await pusher.subscribe(channelName: channelName);
      await pusher.connect();
    } catch (e) {
      print("PUSHER INIT ERROR >>>>>>>>> $e");
    }
  }

  void listenForEvent(String eventName, Function(dynamic) callback) {
    // pusher.bind(eventName, callback);
  }

  // void unsubscribeFromChannel() {
  //   pusher.unsubscribe(channelName: 'YOUR_CHANNEL_NAME');
  // }

  // void disconnectPusher() {
  //   pusher.disconnect();
  // }
}

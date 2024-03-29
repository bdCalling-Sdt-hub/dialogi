import 'package:dialogi_app/helper/prefs_helper.dart';
import 'package:dialogi_app/services/api_url.dart';
import 'package:dialogi_app/services/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketServices {
  static late io.Socket socket;
  bool show = false;

  static void connectToSocket() {
    socket = io.io(
        ApiConstant.baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build());

    socket.onConnect((data) {
      debugPrint("=============================> Connection $data");
    });
    socket.onConnectError((data) {
      print("============================>Connection Error $data");
    });

    socket.connect();

    // socket.on('user-notification::${SharedPreferenceHelper.id}', (data) {
    //   print("================> get Data on socket: $data");
    //   notificationService.showNotification(data);
    // });
    //
    // socket.on('blocked-user::${SharedPreferenceHelper.id}', (data) {
    //   // print("================> get Data on socket: $data");
    //   //
    //   // print(data);
    //   // print(data.runtimeType);
    //
    //   print(data['statusCode'].toString());
    //   print(data['message'].toString());
    //
    //   if (data['statusCode'] == 1000) {
    //     sharedPreferenceHelper.logOut() ;
    //     // Get.offAllNamed(AppRoute.logIn);
    //     Utils.toastMessage(data['message']);
    //   }
    //   // notificationService.showNotification(data);
    // });
  }

  static void notifications() {
    NotificationService notificationService = NotificationService();

    socket.on('user-notification::${PrefsHelper.clientId}', (data) {
      print("================> get Data on socket: $data");
      notificationService.showNotification(data);
    });
  }
}

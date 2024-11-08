import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;
  var messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('http://192.168.100.110:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.on('connect', (_) => print('Connected to Socket.IO server'));

    // Listening for messages from the server
    socket.on('receive_message', (data) {
      messages.add(data);
    });
  }

  void sendMessage(String message, String roomId) {
    socket.emit('send_message', {
      'message': message,
      'roomId': roomId,
    });
  }

  void joinRoom(String roomId) {
    socket.emit('joinRoom', roomId);
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}

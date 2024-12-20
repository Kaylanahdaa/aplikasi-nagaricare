import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  late IO.Socket socket;
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  void _initializeSocket() {
    socket = IO.io('http://192.168.100.110:8080', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.connect();
    socket.on('connect', (_) => print('Connected to Socket.IO server'));

    // Listen for incoming messages
    socket.on('receiveMessage', (data) {
      messages.add(data); // Add message to the list
    });

    // Add other event listeners as needed
  }

  void sendMessage(String message, String username) {
    if (message.isNotEmpty) {
      socket.emit('sendMessage', {'sender': username, 'content': message});
    }
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

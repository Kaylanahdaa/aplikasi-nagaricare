import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient extends GetxController {
  IO.Socket? _socket;
  final messages =
      <Map<String, dynamic>>[].obs; // Observable list to store chat messages

  @override
  void onInit() {
    super.onInit();
    initializeSocket();
  }

  // Initialize and configure the Socket.IO client
  void initializeSocket() {
    _socket = IO.io(
      'http://localhost:3000', // Replace with your backend URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // Disable auto-connect for manual control
          .build(),
    );

    _socket?.onConnect((_) {
      print('Connected to Socket.IO server');
    });

    _socket?.onDisconnect((_) {
      print('Disconnected from server');
    });

    // Listen for messages from the server
    _socket?.on('receive_message', (data) {
      print('Message received: $data');
      messages.add(data); // Add received message to the messages list
    });

    // Manually connect the socket
    _socket?.connect();
  }

  // Join a chat room
  void joinRoom(String roomId) {
    _socket?.emit('joinRoom', roomId);
    print('Joined room: $roomId');
  }

  // Send a message
  void sendMessage(String message) {
    final data = {'message': message};
    _socket?.emit('send_message', data);
    messages.add(data); // Add sent message to the messages list
    print('Message sent: $message');
  }

  // Clean up the socket connection when the controller is disposed
  @override
  void onClose() {
    _socket?.disconnect();
    super.onClose();
  }
}

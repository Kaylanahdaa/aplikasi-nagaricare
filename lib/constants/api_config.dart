import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiUrlFromConfig = dotenv.env['IP_ADDRESS'];

String? socketUrlFromConfig = dotenv.env['SOCKET_ADDRESS'];

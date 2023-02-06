import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TestNotification extends StatefulWidget {
  const TestNotification({Key? key}) : super(key: key);

  @override
  _TestNotificationState createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  late IO.Socket socket;

  @override
  void initState() {
    Connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      child: Text("hit me"),
      onPressed: () => Connect(),
    ));
  }
}
// class StreamSocket{
//
//   final _socketResponse= StreamController<String>();
//
//   void Function(String) get addResponse => _socketResponse.sink.add;
//
//   Stream<String> get getResponse => _socketResponse.stream;
//
//
//   void dispose(){
//     _socketResponse.close();
//   }
// }
//
// StreamSocket streamSocket =StreamSocket();
//
// void connectAndListen()async{
//
//   final SharedPreferences prefs =
//       await SharedPreferences.getInstance();
//   String token = prefs.getString("access_token").toString();
//   log(token);
//   log("jk");
//   Socket socket = io('wss://api-soori-ims-staging.dipendranath.com.np/ws/notification?Token="$token"',
//       OptionBuilder()
//           .setTransports(['websocket']).build());
//   socket.onConnect( (data) => log(data));
//   socket.onDisconnect((_) => log('disconnect'));
//   socket.on('fromServer', (_) => log("sa"+_));
//   // socket.onConnect((_) {
//   //   log('connect');
//   //    socket.emit('msg', 'test');
//   // });
//   //
//   // socket.on('event', (data) => streamSocket.addResponse);
//   // socket.onDisconnect((_) => log('disconnect'));
//   // log(streamSocket.getResponse.toString());
//   // log(streamSocket.runtimeType.toString());
//
// }

// class BuildWithSocketStream extends StatelessWidget {
//   const BuildWithSocketStream({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     log(streamSocket._socketResponse.toString());
//     return Container(
//       child: StreamBuilder(
//         stream: streamSocket.getResponse,
//         builder: (BuildContext context, AsyncSnapshot<String> snapshot){
//           return Container(
//             child: Text(snapshot.data!),
//           );
//         },
//       ),
//     );
//   }
// }
// void main() async{
//   final SharedPreferences prefs =
//       await SharedPreferences.getInstance();
//   String token = prefs.getString("access_token").toString();
//   log(token);
//   log("jk");
//   /// Create the WebSocket channel
//   final channel = WebSocketChannel.connect(
//     Uri.parse('wss://api-soori-ims-staging.dipendranath.com.np/ws/notification?Token="$token"'),
//   );
//
//   /// Listen for all incoming data
// log(channel.sink.done.toString());
// log(channel.sink.runtimeType.toString());
//
//   channel.stream.listen(
//         (data) {
//       log(data);
//     },
//     onError: (error) => print(error),
//   );
//
// }

void Connect() async {
  
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("access_token").toString();
  log(token);
  late IO.Socket socket;
  socket = IO.io(
    "wss://api-soori-ims-staging.dipendranath.com.np/ws/notification?Token='$token'",

  );
  socket.on('Ccnnection', (data) => log('co'));
  socket.connect();
  socket.onConnect((data) => log("data"));
  socket.on('msg', (data) => {
    log(data),
  });
  log(socket.receiveBuffer.runtimeType.toString());
  log("connection:::"+socket.connected.toString());
}

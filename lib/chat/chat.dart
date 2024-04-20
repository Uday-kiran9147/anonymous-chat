import 'package:chat/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String name;
  String uid = const Uuid().v4();
  ChatPage({super.key, required this.name});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  late IO.Socket _socket;
  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    _socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.onConnect((_) {
      print('frontend connected');
      _socket.on('sendMsgServer', (msg) {
        Message newMessage = Message.fromMap(msg);
        if (newMessage.uid != widget.uid) {
          setState(() {
            _messages.add(newMessage);
          });
        }
      });
    });
  }

  final List<Message> _messages = [];

  void _sendMessage() {
    print("send message fn");
    Message newMessage = Message(
        uid: widget.uid,
        message: _controller.text,
        sender: widget.name,
        type: "ownMsg");
    setState(() {
      _messages.add(newMessage);
    });
    if (_controller.text.isNotEmpty) {
      _socket.emit('sendMsg', newMessage.toMap());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous group'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: _messages[index].type == "ownMsg"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 60,
                    ),
                    child: Card(
                      color: _messages[index].type == "ownMsg"
                          ? Colors.blue.shade300
                          : Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _messages[index].sender,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                              ),
                              Text(
                                _messages[index].message,
                                style: TextStyle(fontSize: 14),
                              ),
                            ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

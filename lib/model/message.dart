import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  String message;
  String sender;
  String type;
  String uid;
   Message({
    required this.message,
    required this.sender,
    required this.type,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'sender': sender,
      'type': type,
      'uid': uid,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      message: (map["message"] ?? '') as String,
      sender: (map["sender"] ?? '') as String,
      type: (map["type"] ?? '') as String,
      uid: (map["uid"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);
}

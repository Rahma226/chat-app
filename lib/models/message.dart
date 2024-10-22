import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String content;
  final Timestamp createdAt;

  Message({required this.id, required this.content, required this.createdAt});

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: data['id'] ?? '',
      content: data[Kmessage] ?? '',
      createdAt: data[KcreatedAt],
    );
  }
}

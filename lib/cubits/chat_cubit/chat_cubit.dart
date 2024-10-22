import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Message> messagesList = []; // Store messages here

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  void sendMessage(String data, String email) {
    if (data.trim().isNotEmpty) {
      messages.add({
        Kmessage: data,
        KcreatedAt: DateTime.now(),
        'id': email,
      });
      controller.clear();

      // Animate to the bottom of the chat
      scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void getMessages() {
    messages.orderBy(KcreatedAt, descending: true).snapshots().listen((event) {
      messagesList =
          event.docs.map((doc) => Message.fromFirestore(doc)).toList();
      emit(ChatSuccess());
    });
  }
}

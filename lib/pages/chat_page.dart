import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) => ChatCubit()..getMessages(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kLogo, height: 50),
              const Text(
                ' Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ChatInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatSuccess) {
              final messagesList = context.read<ChatCubit>().messagesList;
              final _controller = context.read<ChatCubit>().scrollController;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller, 
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(message: messagesList[index])
                            : ChatBubbleFreind(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 72, 121, 130),
                      controller: context.read<ChatCubit>().controller,
                      onSubmitted: (data) {
                        context.read<ChatCubit>().sendMessage(data, email);
                      },
                      decoration: InputDecoration(
                        hintText: 'write a message',
                        hintStyle: const TextStyle(
                          color: Color(0xff9C9C9C),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            context.read<ChatCubit>().sendMessage(
                                context.read<ChatCubit>().controller.text,
                                email);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 72, 121, 130),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text('Failed to load messages'));
            }
          },
        ),
      ),
    );
  }
}

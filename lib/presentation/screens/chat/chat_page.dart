import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/chat/message_chat.dart';
import 'package:auto_route/annotations.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';

import '../../../logic/blocs/chat_bloc/chat_bloc.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final String holidayId;

  const ChatScreen({
    super.key,
    @PathParam() required this.holidayId,
  });

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatScreen> {
  final ChatBloc _chatBloc = ChatBloc();
  final List<ChatMessage> messages = [
    ChatMessage(
      text: "Salut, comment ça va fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff?",
      sender: "Alice",
      sendAt: DateTime.now(),
      isUserMessage: false,
    ),

    ChatMessage(
      text: "Bonjour ! Je vais bien, merci.",
      sender: "Bob",
      sendAt: DateTime.now(),
      isUserMessage: true,
    ),

    ChatMessage(
      text: "Et toi, comment vas-tu ?",
      sender: "Bob",
      sendAt: DateTime.now(),
      isUserMessage: true,
    ),

    ChatMessage(
      text: "JE vais bien merci !",
      sender: "Bob",
      sendAt: DateTime.now(),
      isUserMessage: false,
    ),

  ];


  @override
  void initState() {
    _chatBloc.add(JoinRoom(
        holidayId: widget.holidayId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),

      body: _buildListMessage()
    );
  }

  Widget _buildListMessage(){
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _chatBloc,
        child: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state.status == ChatStateStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
            }
          },
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state.status == ChatStateStatus.joined) {
                return _buildChat(context);
              }  else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChat(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return messages[index];
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Entrez votre message...",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Gérer l'envoi du message
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}






import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/message/message.dart';
import 'package:holiday_mobile/data/providers/signalr/connection_hub.dart';
import 'package:holiday_mobile/presentation/widgets/chat/message_chat.dart';
import 'package:auto_route/annotations.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';

import '../../../logic/blocs/chat_bloc/chat_bloc.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final String holidayId;
  final String holidayName;

  const ChatScreen({
    super.key,
    @PathParam() required this.holidayName,
    @PathParam() required this.holidayId,
  });

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatScreen> {
  final ChatBloc _chatBloc = ChatBloc();
  List<Message> messages = [];
  ConnectionHub? connectionHub;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    try{
      connectionHub = ConnectionHub(_chatBloc);
      connectionHub?.joinRoom(widget.holidayId);
    }catch (e){
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(CustomMessage(message: "Erreur lors de la récupération de vos messages").build(context));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.holidayName),
        backgroundColor: const Color(0xFF1E3A8A),
      ),

      body: _buildListMessage()
    );
  }

  Widget _buildListMessage(){
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) =>  _chatBloc,
        child: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state.status == ChatStateStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(CustomMessage(message: state.errorMessage!).build(context));
            }
          },
          child: BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) => previous.numberMessage != current.numberMessage,
            builder: (context, state) {
              print(state.numberMessage);
              messages = state.messageList!;

              WidgetsBinding.instance!.addPostFrameCallback((_) {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
              return _buildChat(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChat(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatMessage(message: messages[index]);
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Entrez votre message...",
                  ),
                  onChanged: (value) {
                    _chatBloc.add(MessageChanged(message: value));
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _chatBloc.add(MessageSent(connectionHub: connectionHub!, holidayId: widget.holidayId));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}






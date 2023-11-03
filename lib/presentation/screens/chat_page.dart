import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/message_chat.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),

      body: Column(
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
      ),
    );
  }
}




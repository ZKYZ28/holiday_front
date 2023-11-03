import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body : Column(
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

/*MESSAGE*/
class ChatMessage extends StatelessWidget {
  final String text;
  final String sender;
  final DateTime sendAt;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage, required String this.sender, required DateTime this.sendAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage)
            const Padding(
              padding: EdgeInsets.only(right: 8.0, left: 4.0),
              child: Icon(Icons.account_circle),
            ),

          Column(
            crossAxisAlignment: isUserMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isUserMessage ? const Color(0xFF1E3A8A) : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12.0),

                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.visible,
                    textAlign: isUserMessage ? TextAlign.end : TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ),

              Text(
                '${DateFormat('dd/MM/yyyy à HH:mm').format(sendAt)} par ${sender}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),


          if (isUserMessage)
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 4.0),
              child: Icon(Icons.account_circle),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
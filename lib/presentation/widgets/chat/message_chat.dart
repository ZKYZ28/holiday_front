import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/message/message.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:holiday_mobile/logic/blocs/chat_bloc/chat_bloc.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  final Message message;

  ChatMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    //TODO CHANGER AVEC L'UTILISATEUR CONNECTE
    final user = UserAuthentificated(id: "c01eb36d-d676-4878-bc3c-b9710e4a37ba", firstName: "François", lastName: "Mahy", email: "Francis@gmail.com");

    bool isUserMessage = message.participantId == user.id;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: isUserMessage? MainAxisAlignment.end : MainAxisAlignment.start,
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
                    message.content,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.visible,
                    textAlign: isUserMessage ? TextAlign.end : TextAlign.start,
                    softWrap: true,
                  ),
                ),
              ),

              Text(
                '${DateFormat('dd/MM/yyyy à HH:mm').format(DateTime.parse(message.sendAt))} par ${message.participant.firstName}  ${message.participant.lastName}',
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
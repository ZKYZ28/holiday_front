import 'dart:convert';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../../logic/blocs/chat_bloc/chat_bloc.dart';
import '../../models/message/message.dart';

class ConnectionHub {
  final serverUrl = "https://10.0.2.2:7048/chat";
  late final HubConnection hubConnection;
  List<Message> messagesList = [];
  ChatBloc? chatBloc;

  ConnectionHub(ChatBloc this.chatBloc) {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  void joinRoom(String holidayId) async {
    //TODO CHANGER AVEC L'UTILISATEUR CONNECTE
    final user = UserAuthentificated(id: "c01eb36d-d676-4878-bc3c-b9710e4a37ba", firstName: "François", lastName: "Mahy", email: "Francis@gmail.com", exp: 12345);

    try{

      hubConnection.on('ReceiveSendMessage', (arguments) {
        final jsonString = json.encode(arguments?[0]);
        final messageObj = Message.fromJson(json.decode(jsonString));

        messagesList.add(messageObj);

        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      hubConnection.on('ReceiveHistoryMessage', (arguments) {
        final jsonString = json.encode(arguments);
        final messagesJson = json.decode(jsonString);

        for(Map<String, dynamic> message in messagesJson[0]){
          messagesList.add(Message.fromJson(message));
        }

        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      hubConnection.on('ReceiveWelcomeMessage', (arguments) {
        final jsonString = json.encode(arguments?[0]);
        final messageObj = Message.fromJson(json.decode(jsonString));

        messagesList.add(messageObj);

        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      hubConnection.on('ClearMessages', (arguments) {
        messagesList = [];
        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      await hubConnection.start();

      final result = await hubConnection.invoke("JoinRoom", args: <Object>[holidayId, user]);

    }catch (e, stacktrace){
      //TODO CHANGER ET FAIRE UNE SIGNAL R EXCEPTION
      throw ApiException("Une erreur s'est produite lorsque vous avez rejoint le chat", stacktrace);
    }

  }


  void sendMessage(String holidayId, String message) async {
    try{
      //TODO CHANGER AVEC L'UTILISATEUR CONNECTE
      final user = UserAuthentificated(id: "c01eb36d-d676-4878-bc3c-b9710e4a37ba", firstName: "François", lastName: "Mahy", email: "Francis@gmail.com", exp: 12345);

      await hubConnection.invoke('SendMessage', args: <Object>[user, holidayId, message]);
    }catch (e, stacktrace){
      //TODO CHANGER ET FAIRE UNE SIGNAL R EXCEPTION
      throw ApiException("Une erreur s'est produite lorsque vous avez rejoint le chat", stacktrace);
    }
  }

}
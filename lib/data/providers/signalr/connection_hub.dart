import 'dart:convert';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/exceptions/signlar_exception.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../../logic/blocs/chat_bloc/chat_bloc.dart';
import '../../models/message/message.dart';

class ConnectionHub {
  final serverUrl = "https://10.0.2.2:7048/chat";
  HubConnection? hubConnection;
  List<Message> messagesList = [];
  ChatBloc? chatBloc;

  ConnectionHub(ChatBloc this.chatBloc);

  void joinRoom(String holidayId, UserAuthentificated user) async {

    try{
      var newHubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
      hubConnection = newHubConnection;

      hubConnection!.on('ReceiveSendMessage', (arguments) {
        final jsonString = json.encode(arguments?[0]);
        final messageObj = Message.fromJson(json.decode(jsonString));

        messagesList.add(messageObj);

        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      hubConnection!.on('ReceiveHistoryMessage', (arguments) {
        final jsonString = json.encode(arguments);
        final messagesJson = json.decode(jsonString);

        for(Map<String, dynamic> message in messagesJson[0]){
          messagesList.add(Message.fromJson(message));
        }

        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      hubConnection!.on('ClearMessages', (arguments) {
        messagesList = [];
        chatBloc?.add(UpdateMessage(messages: messagesList));
      });

      await hubConnection!.start();
      final result = await hubConnection!.invoke("JoinRoom", args: <Object>[holidayId, user]);

    }catch (e, stacktrace){
      throw SignalRException("Une erreur s'est produite lorsque vous avez rejoint le chat", stacktrace);
    }

  }


  void sendMessage(String holidayId, String message, UserAuthentificated user) async {
    try{
      await hubConnection!.invoke('SendMessage', args: <Object>[user, holidayId, message]);
    }catch (e, stacktrace){
      throw SignalRException("Une erreur s'est produite lorsque vous avez envoyé un message", stacktrace);
    }
  }

  void leaveHolidayRoom(String holidayId, UserAuthentificated user) async {
    try{
      await hubConnection!.invoke('LeaveHolidayRoom', args: <Object>[holidayId, user]);
      await hubConnection!.stop();

    }catch (e, stacktrace){
      throw SignalRException("Une erreur s'est produite lorsque vous avez quitter le chat", stacktrace);
    }
  }

}
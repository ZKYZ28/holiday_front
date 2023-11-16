import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ConnectionHub {
  final serverUrl = "https://localhost:7048/chat";
  late final HubConnection hubConnection;


  ConnectionHub() {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  void joinRoom(String holidayId) async {
    final user = UserAuthentificated(id: "c01eb36d-d676-4878-bc3c-b9710e4a37ba", firstName: "François", lastName: "Mahy", email: "Francis@gmail.com", exp: 12345);

    try{
      await hubConnection.start();
      final result = await hubConnection.invoke("JoinRoom", args: <Object>[holidayId, user]);

      hubConnection.on('ReceiveWelcomeMessage', (arguments) {
        print(arguments);
      });

    }catch (e, stacktrace){
      print(e);
      throw ApiException("Une erreur s'est produite lorsque vous avez rejoint le chat", stacktrace);
    }

  }
}
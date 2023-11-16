import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/message/message.dart';
import 'package:holiday_mobile/data/providers/signalr/connection_hub.dart';

part 'chat_event.dart';
part 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {

  ChatBloc() : super(const ChatState()) {

    on<JoinRoom>((JoinRoom event, Emitter<ChatState> emit) async {
      try{
      ConnectionHub connectionHub = ConnectionHub();
      connectionHub.joinRoom(event.holidayId);

      emit(state.copyWith(status: ChatStateStatus.joined));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ChatStateStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
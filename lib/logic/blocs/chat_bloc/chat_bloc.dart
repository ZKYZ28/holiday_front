import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/message/message.dart';
import 'package:holiday_mobile/data/providers/signalr/connection_hub.dart';

part 'chat_event.dart';
part 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {

  ChatBloc() : super(const ChatState()) {
    on<UpdateMessage>((UpdateMessage event, Emitter<ChatState> emit) async {
      try{
        emit(state.copyWith(messageList: event.messages, numberMessage: event.messages.length));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ChatStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<MessageChanged>((MessageChanged event, Emitter<ChatState> emit) async {
      emit(
          state.copyWith(
              status: ChatStateStatus.changed,
              message: event.message
          )
      );
    });

    on<MessageSent>((MessageSent event, Emitter<ChatState> emit) async {
      if(state.message.isNotEmpty){
        event.connectionHub.sendMessage(event.holidayId, state.message);
        emit(state.copyWith(status: ChatStateStatus.sent));
      }else{
        print("NOT GOOD");
      }
    });
  }
}
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/signlar_exception.dart';
import 'package:holiday_mobile/data/models/message/message.dart';
import 'package:holiday_mobile/data/providers/signalr/connection_hub.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  late AuthRepository _repository;
  late ConnectionHub _connectionHub;

  ChatBloc({ required AuthRepository repository}) : super(const ChatState()) {
  _repository = repository;
  _connectionHub = ConnectionHub(this);

    on<JoinRoom>((JoinRoom event, Emitter<ChatState> emit) async {
      try{
        emit(state.copyWith(userId: _repository.userConnected!.id));
        _connectionHub.joinRoom(event.holidayId, _repository.userConnected!);
      } on SignalRException catch (e) {
        emit(state.copyWith(status: ChatStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<UpdateMessage>((UpdateMessage event, Emitter<ChatState> emit) async {
      try{
        emit(state.copyWith(messageList: event.messages, numberMessage: event.messages.length));
      } on SignalRException catch (e) {
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
      try{
        if(state.message.isNotEmpty){
          _connectionHub.sendMessage(event.holidayId, state.message,  _repository.userConnected!);

          emit(state.copyWith(status: ChatStateStatus.sent, message: ""));
        }
      }on SignalRException catch (e) {
        emit(state.copyWith(
            status: ChatStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<LeaveRoom>((LeaveRoom event, Emitter<ChatState> emit) async {
      try{
        _connectionHub.leaveHolidayRoom(event.holidayId, _repository.userConnected!);
        emit(state.copyWith(numberMessage: -1));
      } on SignalRException catch (e) {
        emit(state.copyWith(status: ChatStateStatus.error, errorMessage: e.toString()));
      }
    });
  }
}
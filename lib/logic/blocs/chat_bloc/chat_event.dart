part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable{
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class JoinRoom extends ChatEvent {
  final String holidayId;

  const JoinRoom({required this.holidayId});

  @override
  List<Object> get props => [holidayId];
}


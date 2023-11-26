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

class LeaveRoom extends ChatEvent {
  final String holidayId;

  const LeaveRoom({required this.holidayId});

  @override
  List<Object> get props => [holidayId];
}

class UpdateMessage extends ChatEvent {
  final List<Message> messages;

  const UpdateMessage({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageChanged extends ChatEvent {
  final String message;
  const MessageChanged({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageSent extends ChatEvent {
  final String holidayId;
  const MessageSent({required this.holidayId});

  @override
  List<Object> get props => [holidayId];
}


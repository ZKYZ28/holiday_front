part of 'chat_bloc.dart';

enum ChatStateStatus {joined, error}

class ChatState extends Equatable{
  final ChatStateStatus status;
  final List<Message>? messageList;
  final String errorMessage;

  const ChatState({
    this.status = ChatStateStatus.joined,
    this.messageList = const [],
    this.errorMessage = ""
  });

  ChatState copyWith({
    ChatStateStatus? status,
    List<Message>? messageList,
    String? errorMessage
  }) {
    return ChatState(
        status : status ?? this.status,
        messageList: messageList ?? this.messageList,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, messageList, errorMessage];
}
part of 'chat_bloc.dart';

enum ChatStateStatus {unknow, joined, changed, sent, error}

class ChatState extends Equatable{
  final ChatStateStatus status;
  final int? numberMessage;
  final List<Message>? messageList;
  final String message;
  final String errorMessage;

  const ChatState({
    this.status = ChatStateStatus.unknow,
    this.numberMessage = -1,
    this.messageList = const [],
    this.message = "",
    this.errorMessage = ""
  });

  ChatState copyWith({
    ChatStateStatus? status,
    int? numberMessage,
    List<Message>? messageList,
    String? message,
    String? errorMessage,
  }) {
    return ChatState(
        status : status ?? this.status,
        numberMessage : numberMessage ?? this.numberMessage,
        messageList: messageList ?? this.messageList,
        message: message ?? this.message,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [numberMessage, messageList, message, errorMessage];
}
part of 'chat_bloc.dart';

enum ChatStateStatus {unknow, joined, left, changed, sent, error}

class ChatState extends Equatable{
  final ChatStateStatus status;
  final int? numberMessage;
  final List<Message>? messageList;
  final String message;
  final String errorMessage;
  final String userId;

  const ChatState({
    this.status = ChatStateStatus.unknow,
    this.numberMessage = -1,
    this.messageList = const [],
    this.message = "",
    this.errorMessage = "",
    this.userId = ""
  });

  ChatState copyWith({
    ChatStateStatus? status,
    int? numberMessage,
    List<Message>? messageList,
    String? message,
    String? errorMessage,
    String? userId,
  }) {
    return ChatState(
        status : status ?? this.status,
        numberMessage : numberMessage ?? this.numberMessage,
        messageList: messageList ?? this.messageList,
        message: message ?? this.message,
        errorMessage : errorMessage ?? this.errorMessage,
        userId : userId ?? this.userId
    );
  }

  @override
  List<Object?> get props => [numberMessage, messageList, message, errorMessage];
}
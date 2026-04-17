import 'dart:async';

class MessageHandler {
  static final MessageHandler _instance = MessageHandler._internal();

  factory MessageHandler() {
    return _instance;
  }

  MessageHandler._internal() {
    _controller = StreamController<Message>.broadcast();
  }

  late StreamController<Message> _controller;

  Stream<Message> get stream => _controller.stream;

  void sendMessage(Message message) {
    _controller.sink.add(message);
  }

  void dispose() {
    _controller.close();
  }
}

class Message {
  final int what;
  final String msg;

  Message(this.what,this.msg);
}
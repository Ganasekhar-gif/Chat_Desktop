import '../models/message.dart';

abstract class MessageInterceptor {
  Future<Message> outbound(Message original);
  Future<Message> inbound(Message encrypted);
}

class PlainTextInterceptor implements MessageInterceptor {
  @override
  Future<Message> outbound(Message original) async => original;

  @override
  Future<Message> inbound(Message encrypted) async => encrypted;
}
 

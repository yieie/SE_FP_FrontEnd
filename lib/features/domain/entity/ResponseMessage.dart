class ResponseMessage {
  final bool success;
  final String ? usertype;
  final String message;

  ResponseMessage({
    required this.success, this.usertype, required this.message
  });
}
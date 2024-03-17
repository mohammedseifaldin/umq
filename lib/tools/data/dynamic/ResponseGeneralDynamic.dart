class ResponseGeneralDynamic {
  final bool isSuccess;
  final int status;
  dynamic result;

  ResponseGeneralDynamic({
    required this.isSuccess,
    required this.result,
    required this.status,
  });
}

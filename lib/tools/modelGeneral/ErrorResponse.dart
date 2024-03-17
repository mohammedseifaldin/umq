
import 'package:umq/tools/modelGeneral/Response.dart';

class ErrorResponse extends Response {
  ErrorResponse(int status, String message) : super(status, message);
}

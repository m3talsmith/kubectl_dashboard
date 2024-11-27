import 'exec_action.dart';
import 'http_get_action.dart';
import 'tcp_socket_action.dart';

class LifecycleHandler {
  ExecAction? exec;
  HTTPGetAction? httpGet;
  TCPSocketAction? tcpSocket;

  LifecycleHandler.fromMap(Map<String, dynamic> data) {
    if (data['exec'] != null) {
      exec = ExecAction.fromMap(data['exec']);
    }
    if (data['httpGet'] != null) {
      httpGet = HTTPGetAction.fromMap(data['httpGet']);
    }
    if (data['tcpSocket'] != null) {
      tcpSocket = TCPSocketAction.fromMap(data['tcpSocket']);
    }
  }
}

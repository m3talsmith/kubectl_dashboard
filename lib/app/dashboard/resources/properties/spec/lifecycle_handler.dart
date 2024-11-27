import 'exec_action.dart';
import 'http_get_action.dart';
import 'tcp_socket_action.dart';

class LifecycleHandler {
  late ExecAction exec;
  late HTTPGetAction httpGet;
  late TCPSocketAction tcpSocket;

  LifecycleHandler.fromMap(Map<String, dynamic> data) {
    exec = ExecAction.fromMap(data['exec']);
    httpGet = HTTPGetAction.fromMap(data['httpGet']);
    tcpSocket = TCPSocketAction.fromMap(data['tcpSocket']);
  }
}

import 'exec_action.dart';
import 'grpc_action.dart';
import 'http_get_action.dart';
import 'tcp_socket_action.dart';

class Probe {
  late ExecAction exec;
  late int failureThreshold;
  late GRPCAction grpc;
  late HTTPGetAction httpGet;
  late int initialDelaySeconds;
  late int periodSeconds;
  late int successThreshold;
  late TCPSocketAction tcpSocket;
  late int terminationGracePeriodSeconds;
  late int timeoutSeconds;

  Probe.fromMap(Map<String, dynamic> data) {
    exec = ExecAction.fromMap(data['exec']);
    failureThreshold = data['failureThreshold'];
    grpc = GRPCAction.fromMap(data['grpc']);
    httpGet = HTTPGetAction.fromMap(data['httpGet']);
    initialDelaySeconds = data['initialDelaySeconds'];
    periodSeconds = data['periodSeconds'];
    successThreshold = data['successThreshold'];
    tcpSocket = TCPSocketAction.fromMap(data['tcpSocket']);
    terminationGracePeriodSeconds = data['terminationGracePeriodSeconds'];
    timeoutSeconds = data['timeoutSeconds'];
  }
}

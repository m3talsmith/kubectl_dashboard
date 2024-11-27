class ExecAction {
  late List<String> command;

  ExecAction.fromMap(Map<String, dynamic> data) {
    command = data['command'] as List<String>;
  }
}

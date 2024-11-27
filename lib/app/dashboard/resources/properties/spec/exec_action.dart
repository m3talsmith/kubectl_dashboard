class ExecAction {
  List<String>? command;

  ExecAction.fromMap(Map<String, dynamic> data) {
    if (data['command'] != null) {
      command = [];
      for (var e in data['command']) {
        command!.add(e);
      }
    }
  }
}

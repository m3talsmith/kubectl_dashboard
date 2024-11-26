class ContainerStatus {
  late String name;
  late Map<String, State> state;
  late Map<String, State> lastState;
  bool? running;
  int? restartCount;
  String? image;
  String? imageID;
  String? containerID;
  bool? started;

  ContainerStatus.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    state = (data['state'] as Map<String, dynamic>)
        .entries
        .fold(<String, State>{}, (previousValue, element) {
      previousValue[element.key] = State.fromMap(element.value);
      return previousValue;
    });
    lastState = (data['lastState'] as Map<String, dynamic>)
        .entries
        .fold(<String, State>{}, (previousValue, element) {
      previousValue[element.key] = State.fromMap(element.value);
      return previousValue;
    });
    running = data['running'];
    restartCount = data['restartCount'];
    image = data['image'];
    imageID = data['imageID'];
    containerID = data['containerID'];
    started = data['started'];
  }
}

class State {
  DateTime? startedAt;

  State.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('startedAt')) {
      startedAt = DateTime.parse(data['startedAt']);
    }
  }
}

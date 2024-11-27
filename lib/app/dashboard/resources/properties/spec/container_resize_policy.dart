class ContainerResizePolicy {
  late String resourceName;
  late String restartPolicy;

  ContainerResizePolicy.fromMap(Map<String, dynamic> data) {
    resourceName = data['resourceName'];
    restartPolicy = data['restartPolicy'];
  }
}

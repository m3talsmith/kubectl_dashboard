class OwnerReference {
  late String apiVersion;
  late bool blockOwnerDeletion;
  late bool controller;
  late String kind;
  late String name;
  late String uid;

  OwnerReference.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    blockOwnerDeletion = data['blockOwnerDeletion'];
    controller = data['controller'];
    kind = data['kind'];
    name = data['name'];
    uid = data['uid'];
  }
}

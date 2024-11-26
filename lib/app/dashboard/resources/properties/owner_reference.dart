class OwnerReference {
  late String apiVersion;
  late String kind;
  late String name;
  late String uid;
  late bool? controller;
  late bool? blockOwnerDeletion;

  OwnerReference.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    name = data['name'];
    kind = data['kind'];
    uid = data['uid'];
    controller = data['controller'];
    blockOwnerDeletion = data['blockOwnerDeletion'];
  }
}

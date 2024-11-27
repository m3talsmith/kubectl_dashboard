class ResourceClaim {
  late String name;

  ResourceClaim.fromMap(Map<String, dynamic> data) {
    name = data['name'];
  }
}

class GitRepoVolumeSource {
  late String directory;
  late String repository;
  late String revision;

  GitRepoVolumeSource.fromMap(Map<String, dynamic> data) {
    directory = data['directory'];
    repository = data['repository'];
    revision = data['revision'];
  }
}

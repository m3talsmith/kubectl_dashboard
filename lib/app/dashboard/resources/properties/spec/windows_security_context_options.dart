class WindowsSecurityContextOptions {
  late String gmsaCredentialSpec;
  late String gmsaCredentialSpecName;
  late bool hostProcess;
  late String runAsUserName;

  WindowsSecurityContextOptions.fromMap(Map<String, dynamic> data) {
    gmsaCredentialSpec = data['gmsaCredentialSpec'];
    gmsaCredentialSpecName = data['gmsaCredentialSpecName'];
    hostProcess = data['hostProcess'];
    runAsUserName = data['runAsUserName'];
  }
}

class SecurityContext {
  late Map<String, dynamic> capabilities;
  late bool? allowPrivilegeEscalation;
  late bool? runAsNonRoot;
  late Map<String, String> seccompProfile;

  SecurityContext.fromMap(Map<String, dynamic> data) {
    capabilities = {};
    if (data.containsKey('capabilities')) {
      (data['capabilities'] as Map<String, dynamic>)
          .forEach((key, value) => capabilities[key] = value);
    }
    allowPrivilegeEscalation = data['allowPrivilegeEscalation'];
    runAsNonRoot = data['runAsNonRoot'];
    seccompProfile = {};
    if (data.containsKey('seccompProfile')) {
      (data['seccompProfile'] as Map<String, dynamic>)
          .forEach((key, value) => seccompProfile[key] = value);
    }
  }
}

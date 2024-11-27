import 'capabilities.dart';
import 'se_linux_options.dart';
import 'seccomp_profile.dart';
import 'windows_security_context_options.dart';

class SecurityContext {
  bool? allowPrivilegeEscalation;
  Capabilities? capabilities;
  bool? privileged;
  String? procMount;
  bool? readOnlyRootFilesystem;
  int? runAsGroup;
  bool? runAsNonRoot;
  int? runAsUser;
  SELinuxOptions? seLinuxOptions;
  SeccompProfile? seccompProfile;
  WindowsSecurityContextOptions? windowsOptions;

  SecurityContext.fromMap(Map<String, dynamic> data) {
    allowPrivilegeEscalation = data['allowPrivilegeEscalation'];
    if (data['capabilities'] != null) {
      capabilities = Capabilities.fromMap(data['capabilities']);
    }
    privileged = data['privileged'];
    procMount = data['procMount'];
    readOnlyRootFilesystem = data['readOnlyRootFilesystem'];
    runAsGroup = data['runAsGroup'];
    runAsNonRoot = data['runAsNonRoot'];
    runAsUser = data['runAsUser'];
    if (data['seLinuxOptions'] != null) {
      seLinuxOptions = SELinuxOptions.fromMap(data['seLinuxOptions']);
    }
    if (data['seccompProfile'] != null) {
      seccompProfile = SeccompProfile.fromMap(data['seccompProfile']);
    }
    if (data['windowsOptions'] != null) {
      windowsOptions =
          WindowsSecurityContextOptions.fromMap(data['windowsOptions']);
    }
  }
}

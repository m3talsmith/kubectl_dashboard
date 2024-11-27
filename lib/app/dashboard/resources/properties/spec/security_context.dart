import 'capabilities.dart';
import 'se_linux_options.dart';
import 'seccomp_profile.dart';
import 'windows_security_context_options.dart';

class SecurityContext {
  late bool allowPrivilegeEscalation;
  late Capabilities capabilities;
  late bool privileged;
  late String procMount;
  late bool readOnlyRootFilesystem;
  late int runAsGroup;
  late bool runAsNonRoot;
  late int runAsUser;
  late SELinuxOptions seLinuxOptions;
  late SeccompProfile seccompProfile;
  late WindowsSecurityContextOptions windowsOptions;

  SecurityContext.fromMap(Map<String, dynamic> data) {
    allowPrivilegeEscalation = data['allowPrivilegeEscalation'];
    capabilities = Capabilities.fromMap(data['capabilities']);
    privileged = data['privileged'];
    procMount = data['procMount'];
    readOnlyRootFilesystem = data['readOnlyRootFilesystem'];
    runAsGroup = data['runAsGroup'];
    runAsNonRoot = data['runAsNonRoot'];
    runAsUser = data['runAsUser'];
    seLinuxOptions = SELinuxOptions.fromMap(data['seLinuxOptions']);
    seccompProfile = SeccompProfile.fromMap(data['seccompProfile']);
    windowsOptions =
        WindowsSecurityContextOptions.fromMap(data['windowsOptions']);
  }
}

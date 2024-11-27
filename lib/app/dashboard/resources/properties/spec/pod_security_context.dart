import 'se_linux_options.dart';
import 'seccomp_profile.dart';
import 'sysctl.dart';
import 'windows_security_context_options.dart';

class PodSecurityContext {
  late int fsGroup;
  late String fsGroupChangePolicy;
  late int runAsGroup;
  late bool runAsNonRoot;
  late int runAsUser;
  late SELinuxOptions seLinuxOptions;
  late SeccompProfile seccompProfile;
  late List<int> supplementalGroups;
  late List<Sysctl> sysctls;
  late WindowsSecurityContextOptions windowsOptions;

  PodSecurityContext.fromMap(Map<String, dynamic> data) {
    fsGroup = data['fsGroup'];
    fsGroupChangePolicy = data['fsGroupChangePolicy'];
    runAsGroup = data['runAsGroup'];
    runAsNonRoot = data['runAsNonRoot'];
    runAsUser = data['runAsUser'];
    seLinuxOptions = SELinuxOptions.fromMap(data['seLinuxOptions']);
    seccompProfile = SeccompProfile.fromMap(data['seccompProfile']);
    supplementalGroups = data['supplementalGroups'] as List<int>;
    sysctls = (data['sysctls'] as List<Map<String, dynamic>>)
        .map(
          (e) => Sysctl.fromMap(e),
        )
        .toList();
    windowsOptions =
        WindowsSecurityContextOptions.fromMap(data['windowsOptions']);
  }
}

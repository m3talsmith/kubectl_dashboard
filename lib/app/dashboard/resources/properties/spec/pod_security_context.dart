import 'se_linux_options.dart';
import 'seccomp_profile.dart';
import 'sysctl.dart';
import 'windows_security_context_options.dart';

class PodSecurityContext {
  int? fsGroup;
  String? fsGroupChangePolicy;
  int? runAsGroup;
  bool? runAsNonRoot;
  int? runAsUser;
  SELinuxOptions? seLinuxOptions;
  SeccompProfile? seccompProfile;
  List<int>? supplementalGroups;
  List<Sysctl>? sysctls;
  WindowsSecurityContextOptions? windowsOptions;

  PodSecurityContext.fromMap(Map<String, dynamic> data) {
    fsGroup = data['fsGroup'];
    fsGroupChangePolicy = data['fsGroupChangePolicy'];
    runAsGroup = data['runAsGroup'];
    runAsNonRoot = data['runAsNonRoot'];
    runAsUser = data['runAsUser'];
    if (data['seLinuxOptions'] != null) {
      seLinuxOptions = SELinuxOptions.fromMap(data['seLinuxOptions']);
    }
    if (data['seccompProfile'] != null) {
      seccompProfile = SeccompProfile.fromMap(data['seccompProfile']);
    }
    if (data['supplementalGroups'] != null) {
      supplementalGroups = [];
      for (var e in data['supplementalGroups']) {
        supplementalGroups!.add(e);
      }
    }
    if (data['sysctls'] != null) {
      sysctls = [];
      for (var e in data['sysctls']) {
        sysctls!.add(Sysctl.fromMap(e));
      }
    }
    if (data['windowsOptions'] != null) {
      windowsOptions =
          WindowsSecurityContextOptions.fromMap(data['windowsOptions']);
    }
  }
}

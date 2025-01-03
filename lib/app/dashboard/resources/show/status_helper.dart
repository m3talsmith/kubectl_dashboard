// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:kuberneteslib/kuberneteslib.dart';

class StatusHelper {
  static Status? fromKind(ResourceKind kind, Status? status) {
    if (status == null) {
      return null;
    }
    switch (kind) {
            case ResourceKind.container:
        return ContainerStatus.fromJson(status.toJson());

      case ResourceKind.pod:
        return PodStatus.fromJson(status.toJson());

      case ResourceKind.replicationController:
        return ReplicationControllerStatus.fromJson(status.toJson());

      case ResourceKind.endpoints:
        return EndpointsStatus.fromJson(status.toJson());

      case ResourceKind.volume:
        return VolumeStatus.fromJson(status.toJson());

      case ResourceKind.binding:
        return BindingStatus.fromJson(status.toJson());

      case ResourceKind.persistentVolume:
        return PersistentVolumeStatus.fromJson(status.toJson());

      case ResourceKind.daemonSet:
        return DaemonSetStatus.fromJson(status.toJson());

      case ResourceKind.deployment:
        return DeploymentStatus.fromJson(status.toJson());

      case ResourceKind.replicaSet:
        return ReplicaSetStatus.fromJson(status.toJson());

      case ResourceKind.statefulSet:
        return StatefulSetStatus.fromJson(status.toJson());

      case ResourceKind.controllerRevision:
        return ControllerRevisionStatus.fromJson(status.toJson());

      case ResourceKind.cronJob:
        return CronJobStatus.fromJson(status.toJson());

      case ResourceKind.job:
        return JobStatus.fromJson(status.toJson());

      case ResourceKind.podSet:
        return PodSetStatus.fromJson(status.toJson());

      case ResourceKind.nodeSet:
        return NodeSetStatus.fromJson(status.toJson());

      case ResourceKind.namespaceSet:
        return NamespaceSetStatus.fromJson(status.toJson());

      case ResourceKind.secretSet:
        return SecretSetStatus.fromJson(status.toJson());

      case ResourceKind.configMapSet:
        return ConfigMapSetStatus.fromJson(status.toJson());

      case ResourceKind.serviceSet:
        return ServiceSetStatus.fromJson(status.toJson());

      case ResourceKind.endpointSet:
        return EndpointSetStatus.fromJson(status.toJson());

      case ResourceKind.service:
        return ServiceStatus.fromJson(status.toJson());

      case ResourceKind.configMap:
        return ConfigMapStatus.fromJson(status.toJson());

      case ResourceKind.secret:
        return SecretStatus.fromJson(status.toJson());

      case ResourceKind.persistentVolumeClaim:
        return PersistentVolumeClaimStatus.fromJson(status.toJson());

      case ResourceKind.volumeSet:
        return VolumeSetStatus.fromJson(status.toJson());

      case ResourceKind.eventSet:
        return EventSetStatus.fromJson(status.toJson());

      case ResourceKind.customResourceDefinition:
        return CustomResourceDefinitionStatus.fromJson(status.toJson());

      case ResourceKind.limitRange:
        return LimitRangeStatus.fromJson(status.toJson());

      case ResourceKind.mutatingWebhookConfiguration:
        return MutatingWebhookConfigurationStatus.fromJson(status.toJson());

      case ResourceKind.validatingWebhookConfiguration:
        return ValidatingWebhookConfigurationStatus.fromJson(status.toJson());

      case ResourceKind.podTemplate:
        return PodTemplateStatus.fromJson(status.toJson());

      case ResourceKind.podDisruptionBudget:
        return PodDisruptionBudgetStatus.fromJson(status.toJson());

      case ResourceKind.componentStatus:
        return ComponentStatusStatus.fromJson(status.toJson());

      case ResourceKind.namespace:
        return NamespaceStatus.fromJson(status.toJson());

      case ResourceKind.node:
        return NodeStatus.fromJson(status.toJson());

      case ResourceKind.resourceQuota:
        return ResourceQuotaStatus.fromJson(status.toJson());

      case ResourceKind.serviceAccount:
        return ServiceAccountStatus.fromJson(status.toJson());

      case ResourceKind.event:
        return EventStatus.fromJson(status.toJson());

      case ResourceKind.eventSeries:
        return EventSeriesStatus.fromJson(status.toJson());

      default:
        return null;
    }
  }
}

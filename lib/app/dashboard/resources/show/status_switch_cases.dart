import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kuberneteslib/kuberneteslib.dart';

import 'status_tiles/container_status_view.dart';
import 'status_tiles/pod_status_view.dart';
import 'status_tiles/replication_controller_status_view.dart';
import 'status_tiles/endpoints_status_view.dart';
import 'status_tiles/volume_status_view.dart';
import 'status_tiles/binding_status_view.dart';
import 'status_tiles/persistent_volume_status_view.dart';
import 'status_tiles/daemon_set_status_view.dart';
import 'status_tiles/deployment_status_view.dart';
import 'status_tiles/replica_set_status_view.dart';
import 'status_tiles/stateful_set_status_view.dart';
import 'status_tiles/controller_revision_status_view.dart';
import 'status_tiles/cron_job_status_view.dart';
import 'status_tiles/job_status_view.dart';
import 'status_tiles/pod_set_status_view.dart';
import 'status_tiles/node_set_status_view.dart';
import 'status_tiles/namespace_set_status_view.dart';
import 'status_tiles/secret_set_status_view.dart';
import 'status_tiles/config_map_set_status_view.dart';
import 'status_tiles/service_set_status_view.dart';
import 'status_tiles/endpoint_set_status_view.dart';
import 'status_tiles/service_status_view.dart';
import 'status_tiles/config_map_status_view.dart';
import 'status_tiles/secret_status_view.dart';
import 'status_tiles/persistent_volume_claim_status_view.dart';
import 'status_tiles/volume_set_status_view.dart';
import 'status_tiles/event_set_status_view.dart';
import 'status_tiles/custom_resource_definition_status_view.dart';
import 'status_tiles/limit_range_status_view.dart';
import 'status_tiles/mutating_webhook_configuration_status_view.dart';
import 'status_tiles/validating_webhook_configuration_status_view.dart';
import 'status_tiles/pod_template_status_view.dart';
import 'status_tiles/pod_disruption_budget_status_view.dart';
import 'status_tiles/component_status_status_view.dart';
import 'status_tiles/namespace_status_view.dart';
import 'status_tiles/node_status_view.dart';
import 'status_tiles/resource_quota_status_view.dart';
import 'status_tiles/service_account_status_view.dart';
import 'status_tiles/event_status_view.dart';
import 'status_tiles/event_series_status_view.dart';

Widget buildStatus({Status? status}) {
  if (status == null) {
    log('[buildStatus] status is null');
    return const SizedBox.shrink();
  }
  switch (status.runtimeType) {
    case ContainerStatus status:
  log('[ContainerStatusView] status: ${status.toJson()}');
  return ContainerStatusView(status: status! as ContainerStatus);

		case PodStatus status:
  log('[PodStatusView] status: ${status.toJson()}');
  return PodStatusView(status: status! as PodStatus);

		case ReplicationControllerStatus status:
  log('[ReplicationControllerStatusView] status: ${status.toJson()}');
  return ReplicationControllerStatusView(status: status! as ReplicationControllerStatus);

		case EndpointsStatus status:
  log('[EndpointsStatusView] status: ${status.toJson()}');
  return EndpointsStatusView(status: status! as EndpointsStatus);

		case VolumeStatus status:
  log('[VolumeStatusView] status: ${status.toJson()}');
  return VolumeStatusView(status: status! as VolumeStatus);

		case BindingStatus status:
  log('[BindingStatusView] status: ${status.toJson()}');
  return BindingStatusView(status: status! as BindingStatus);

		case PersistentVolumeStatus status:
  log('[PersistentVolumeStatusView] status: ${status.toJson()}');
  return PersistentVolumeStatusView(status: status! as PersistentVolumeStatus);

		case DaemonSetStatus status:
  log('[DaemonSetStatusView] status: ${status.toJson()}');
  return DaemonSetStatusView(status: status! as DaemonSetStatus);

		case DeploymentStatus status:
  log('[DeploymentStatusView] status: ${status.toJson()}');
  return DeploymentStatusView(status: status! as DeploymentStatus);

		case ReplicaSetStatus status:
  log('[ReplicaSetStatusView] status: ${status.toJson()}');
  return ReplicaSetStatusView(status: status! as ReplicaSetStatus);

		case StatefulSetStatus status:
  log('[StatefulSetStatusView] status: ${status.toJson()}');
  return StatefulSetStatusView(status: status! as StatefulSetStatus);

		case ControllerRevisionStatus status:
  log('[ControllerRevisionStatusView] status: ${status.toJson()}');
  return ControllerRevisionStatusView(status: status! as ControllerRevisionStatus);

		case CronJobStatus status:
  log('[CronJobStatusView] status: ${status.toJson()}');
  return CronJobStatusView(status: status! as CronJobStatus);

		case JobStatus status:
  log('[JobStatusView] status: ${status.toJson()}');
  return JobStatusView(status: status! as JobStatus);

		case PodSetStatus status:
  log('[PodSetStatusView] status: ${status.toJson()}');
  return PodSetStatusView(status: status! as PodSetStatus);

		case NodeSetStatus status:
  log('[NodeSetStatusView] status: ${status.toJson()}');
  return NodeSetStatusView(status: status! as NodeSetStatus);

		case NamespaceSetStatus status:
  log('[NamespaceSetStatusView] status: ${status.toJson()}');
  return NamespaceSetStatusView(status: status! as NamespaceSetStatus);

		case SecretSetStatus status:
  log('[SecretSetStatusView] status: ${status.toJson()}');
  return SecretSetStatusView(status: status! as SecretSetStatus);

		case ConfigMapSetStatus status:
  log('[ConfigMapSetStatusView] status: ${status.toJson()}');
  return ConfigMapSetStatusView(status: status! as ConfigMapSetStatus);

		case ServiceSetStatus status:
  log('[ServiceSetStatusView] status: ${status.toJson()}');
  return ServiceSetStatusView(status: status! as ServiceSetStatus);

		case EndpointSetStatus status:
  log('[EndpointSetStatusView] status: ${status.toJson()}');
  return EndpointSetStatusView(status: status! as EndpointSetStatus);

		case ServiceStatus status:
  log('[ServiceStatusView] status: ${status.toJson()}');
  return ServiceStatusView(status: status! as ServiceStatus);

		case ConfigMapStatus status:
  log('[ConfigMapStatusView] status: ${status.toJson()}');
  return ConfigMapStatusView(status: status! as ConfigMapStatus);

		case SecretStatus status:
  log('[SecretStatusView] status: ${status.toJson()}');
  return SecretStatusView(status: status! as SecretStatus);

		case PersistentVolumeClaimStatus status:
  log('[PersistentVolumeClaimStatusView] status: ${status.toJson()}');
  return PersistentVolumeClaimStatusView(status: status! as PersistentVolumeClaimStatus);

		case VolumeSetStatus status:
  log('[VolumeSetStatusView] status: ${status.toJson()}');
  return VolumeSetStatusView(status: status! as VolumeSetStatus);

		case EventSetStatus status:
  log('[EventSetStatusView] status: ${status.toJson()}');
  return EventSetStatusView(status: status! as EventSetStatus);

		case CustomResourceDefinitionStatus status:
  log('[CustomResourceDefinitionStatusView] status: ${status.toJson()}');
  return CustomResourceDefinitionStatusView(status: status! as CustomResourceDefinitionStatus);

		case LimitRangeStatus status:
  log('[LimitRangeStatusView] status: ${status.toJson()}');
  return LimitRangeStatusView(status: status! as LimitRangeStatus);

		case MutatingWebhookConfigurationStatus status:
  log('[MutatingWebhookConfigurationStatusView] status: ${status.toJson()}');
  return MutatingWebhookConfigurationStatusView(status: status! as MutatingWebhookConfigurationStatus);

		case ValidatingWebhookConfigurationStatus status:
  log('[ValidatingWebhookConfigurationStatusView] status: ${status.toJson()}');
  return ValidatingWebhookConfigurationStatusView(status: status! as ValidatingWebhookConfigurationStatus);

		case PodTemplateStatus status:
  log('[PodTemplateStatusView] status: ${status.toJson()}');
  return PodTemplateStatusView(status: status! as PodTemplateStatus);

		case PodDisruptionBudgetStatus status:
  log('[PodDisruptionBudgetStatusView] status: ${status.toJson()}');
  return PodDisruptionBudgetStatusView(status: status! as PodDisruptionBudgetStatus);

		case ComponentStatusStatus status:
  log('[ComponentStatusStatusView] status: ${status.toJson()}');
  return ComponentStatusStatusView(status: status! as ComponentStatusStatus);

		case NamespaceStatus status:
  log('[NamespaceStatusView] status: ${status.toJson()}');
  return NamespaceStatusView(status: status! as NamespaceStatus);

		case NodeStatus status:
  log('[NodeStatusView] status: ${status.toJson()}');
  return NodeStatusView(status: status! as NodeStatus);

		case ResourceQuotaStatus status:
  log('[ResourceQuotaStatusView] status: ${status.toJson()}');
  return ResourceQuotaStatusView(status: status! as ResourceQuotaStatus);

		case ServiceAccountStatus status:
  log('[ServiceAccountStatusView] status: ${status.toJson()}');
  return ServiceAccountStatusView(status: status! as ServiceAccountStatus);

		case EventStatus status:
  log('[EventStatusView] status: ${status.toJson()}');
  return EventStatusView(status: status! as EventStatus);

		case EventSeriesStatus status:
  log('[EventSeriesStatusView] status: ${status.toJson()}');
  return EventSeriesStatusView(status: status! as EventSeriesStatus);

  default:
    log('[buildStatus] default: ${status?.runtimeType}');
    return const SizedBox.shrink();
  }
}

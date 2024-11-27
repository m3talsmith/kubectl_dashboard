import 'volume/aws_elastic_block_store_volume_source.dart';
import 'volume/azure_disk_volume_source.dart';
import 'volume/azure_file_volume_source.dart';
import 'volume/ceph_fs_volume_source.dart';
import 'volume/cinder_volume_source.dart';
import 'volume/config_map_volume_source.dart';
import 'volume/csi_volume_source.dart';
import 'volume/downward_api_volume_source.dart';
import 'volume/empty_dir_volume_source.dart';
import 'volume/ephemeral_volume_source.dart';
import 'volume/fc_volume_source.dart';
import 'volume/flex_volume_source.dart';
import 'volume/flocker_volume_source.dart';
import 'volume/gce_persistent_disk_volume_source.dart';
import 'volume/git_repo_volume_source.dart';
import 'volume/glusterfs_volume_source.dart';
import 'volume/host_path_volume_source.dart';
import 'volume/iscsi_volume_source.dart';
import 'volume/nfs_volume_source.dart';
import 'volume/persistent_volume_claim_volume_source.dart';
import 'volume/photon_persistent_disk_volume_source.dart';
import 'volume/portworx_volume_source.dart';
import 'volume/projected_volume_source.dart';
import 'volume/quobyte_volume_source.dart';
import 'volume/rbd_volume_source.dart';
import 'volume/scale_io_volume_source.dart';
import 'volume/secret_volume_source.dart';
import 'volume/storage_os_volume_source.dart';
import 'volume/vsphere_virtual_disk_volume_source.dart';

// https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/#volume-v1-core
class Volume {
  AWSElasticBlockStoreVolumeSource? awsElasticBlockStore;
  AzureDiskVolumeSource? azureDisk;
  AzureFileVolumeSource? azureFile;
  CephFSVolumeSource? cephfs;
  CinderVolumeSource? cinder;
  ConfigMapVolumeSource? configMap;
  CSIVolumeSource? csi;
  DownwardAPIVolumeSource? downwardAPI;
  EmptyDirVolumeSource? emptyDir;
  EphemeralVolumeSource? ephemeral;
  FCVolumeSource? fc;
  FlexVolumeSource? flexVolume;
  FlockerVolumeSource? flocker;
  GCEPersistentDiskVolumeSource? gcePersistentDisk;
  GitRepoVolumeSource? gitRepo;
  GlusterfsVolumeSource? glusterfs;
  HostPathVolumeSource? hostPath;
  ISCSIVolumeSource? iscsi;
  String? name;
  NFSVolumeSource? nfs;
  PersistentVolumeClaimVolumeSource? persistentVolumeClaim;
  PhotonPersistentDiskVolumeSource? photonPersistentDisk;
  PortworxVolumeSource? portworxVolume;
  ProjectedVolumeSource? projected;
  QuobyteVolumeSource? quobyte;
  RBDVolumeSource? rbd;
  ScaleIOVolumeSource? scaleIO;
  SecretVolumeSource? secret;
  StorageOSVolumeSource? storageos;
  VsphereVirtualDiskVolumeSource? vsphereVolume;

  Volume.fromMap(Map<String, dynamic> data) {
    if (data['awsElasticBlockStore'] != null) {
      awsElasticBlockStore = AWSElasticBlockStoreVolumeSource.fromMap(
          data['awsElasticBlockStore']);
    }
    if (data['azureDisk'] != null) {
      azureDisk = AzureDiskVolumeSource.fromMap(data['azureDisk']);
    }
    if (data['azureFile'] != null) {
      azureFile = AzureFileVolumeSource.fromMap(data['azureFile']);
    }
    if (data['cephfs'] != null) {
      cephfs = CephFSVolumeSource.fromMap(data['cephfs']);
    }
    if (data['cinder'] != null) {
      cinder = CinderVolumeSource.fromMap(data['cinder']);
    }
    if (data['configMap'] != null) {
      configMap = ConfigMapVolumeSource.fromMap(data['configMap']);
    }
    if (data['csi'] != null) {
      csi = CSIVolumeSource.fromMap(data['csi']);
    }
    if (data['downwardAPI'] != null) {
      downwardAPI = DownwardAPIVolumeSource.fromMap(data['downwardAPI']);
    }
    if (data['emptyDir'] != null) {
      emptyDir = EmptyDirVolumeSource.fromMap(data['emptyDir']);
    }
    if (data['ephemeral'] != null) {
      ephemeral = EphemeralVolumeSource.fromMap(data['ephemeral']);
    }
    if (data['fc'] != null) {
      fc = FCVolumeSource.fromMap(data['fc']);
    }
    if (data['flexVolume'] != null) {
      flexVolume = FlexVolumeSource.fromMap(data['flexVolume']);
    }
    if (data['flocker'] != null) {
      flocker = FlockerVolumeSource.fromMap(data['flocker']);
    }
    if (data['gcePersistentDisk'] != null) {
      gcePersistentDisk =
          GCEPersistentDiskVolumeSource.fromMap(data['gcePersistentDisk']);
    }
    if (data['gitRepo'] != null) {
      gitRepo = GitRepoVolumeSource.fromMap(data['gitRepo']);
    }
    if (data['glusterfs'] != null) {
      glusterfs = GlusterfsVolumeSource.fromMap(data['glusterfs']);
    }
    if (data['hostPath'] != null) {
      hostPath = HostPathVolumeSource.fromMap(data['hostPath']);
    }
    if (data['iscsi'] != null) {
      iscsi = ISCSIVolumeSource.fromMap(data['iscsi']);
    }
    name = data['name'];
    if (data['nfs'] != null) {
      nfs = NFSVolumeSource.fromMap(data['nfs']);
    }
    if (data['persistentVolumeClaim'] != null) {
      persistentVolumeClaim = PersistentVolumeClaimVolumeSource.fromMap(
          data['persistentVolumeClaim']);
    }
    if (data['photonPersistentDisk'] != null) {
      photonPersistentDisk = PhotonPersistentDiskVolumeSource.fromMap(
          data['photonPersistentDisk']);
    }
    if (data['portworxVolume'] != null) {
      portworxVolume = PortworxVolumeSource.fromMap(data['portworxVolume']);
    }
    if (data['projected'] != null) {
      projected = ProjectedVolumeSource.fromMap(data['projected']);
    }
    if (data['quobyte'] != null) {
      quobyte = QuobyteVolumeSource.fromMap(data['quobyte']);
    }
    if (data['rbd'] != null) {
      rbd = RBDVolumeSource.fromMap(data['rbd']);
    }
    if (data['scaleIO'] != null) {
      scaleIO = ScaleIOVolumeSource.fromMap(data['scaleIO']);
    }
    if (data['secret'] != null) {
      secret = SecretVolumeSource.fromMap(data['secret']);
    }
    if (data['storageos'] != null) {
      storageos = StorageOSVolumeSource.fromMap(data['storageos']);
    }
    if (data['vsphereVolume'] != null) {
      vsphereVolume =
          VsphereVirtualDiskVolumeSource.fromMap(data['vsphereVolume']);
    }
  }
}

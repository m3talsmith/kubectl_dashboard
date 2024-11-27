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
  late AWSElasticBlockStoreVolumeSource awsElasticBlockStore;
  late AzureDiskVolumeSource azureDisk;
  late AzureFileVolumeSource azureFile;
  late CephFSVolumeSource cephfs;
  late CinderVolumeSource cinder;
  late ConfigMapVolumeSource configMap;
  late CSIVolumeSource csi;
  late DownwardAPIVolumeSource downwardAPI;
  late EmptyDirVolumeSource emptyDir;
  late EphemeralVolumeSource ephemeral;
  late FCVolumeSource fc;
  late FlexVolumeSource flexVolume;
  late FlockerVolumeSource flocker;
  late GCEPersistentDiskVolumeSource gcePersistentDisk;
  late GitRepoVolumeSource gitRepo;
  late GlusterfsVolumeSource glusterfs;
  late HostPathVolumeSource hostPath;
  late ISCSIVolumeSource iscsi;
  late String name;
  late NFSVolumeSource nfs;
  late PersistentVolumeClaimVolumeSource persistentVolumeClaim;
  late PhotonPersistentDiskVolumeSource photonPersistentDisk;
  late PortworxVolumeSource portworxVolume;
  late ProjectedVolumeSource projected;
  late QuobyteVolumeSource quobyte;
  late RBDVolumeSource rbd;
  late ScaleIOVolumeSource scaleIO;
  late SecretVolumeSource secret;
  late StorageOSVolumeSource storageos;
  late VsphereVirtualDiskVolumeSource vsphereVolume;

  Volume.fromMap(Map<String, dynamic> data) {
    awsElasticBlockStore =
        AWSElasticBlockStoreVolumeSource.fromMap(data['awsElasticBlockStore']);
    azureDisk = AzureDiskVolumeSource.fromMap(data['azureDisk']);
    azureFile = AzureFileVolumeSource.fromMap(data['azureFile']);
    cephfs = CephFSVolumeSource.fromMap(data['cephfs']);
    cinder = CinderVolumeSource.fromMap(data['cinder']);
    configMap = ConfigMapVolumeSource.fromMap(data['configMap']);
    csi = CSIVolumeSource.fromMap(data['csi']);
    downwardAPI = DownwardAPIVolumeSource.fromMap(data['downwardAPI']);
    emptyDir = EmptyDirVolumeSource.fromMap(data['emptyDir']);
    ephemeral = EphemeralVolumeSource.fromMap(data['ephemeral']);
    fc = FCVolumeSource.fromMap(data['fc']);
    flexVolume = FlexVolumeSource.fromMap(data['flexVolume']);
    flocker = FlockerVolumeSource.fromMap(data['flocker']);
    gcePersistentDisk =
        GCEPersistentDiskVolumeSource.fromMap(data['gcePersistentDisk']);
    gitRepo = GitRepoVolumeSource.fromMap(data['gitRepo']);
    glusterfs = GlusterfsVolumeSource.fromMap(data['glusterfs']);
    hostPath = HostPathVolumeSource.fromMap(data['hostPath']);
    iscsi = ISCSIVolumeSource.fromMap(data['iscsi']);
    name = data['name'];
    nfs = NFSVolumeSource.fromMap(data['nfs']);
    persistentVolumeClaim = PersistentVolumeClaimVolumeSource.fromMap(
        data['persistentVolumeClaim']);
    photonPersistentDisk =
        PhotonPersistentDiskVolumeSource.fromMap(data['photonPersistentDisk']);
    portworxVolume = PortworxVolumeSource.fromMap(data['portworxVolume']);
    projected = ProjectedVolumeSource.fromMap(data['projected']);
    quobyte = QuobyteVolumeSource.fromMap(data['quobyte']);
    rbd = RBDVolumeSource.fromMap(data['rbd']);
    scaleIO = ScaleIOVolumeSource.fromMap(data['scaleIO']);
    secret = SecretVolumeSource.fromMap(data['secret']);
    storageos = StorageOSVolumeSource.fromMap(data['storageos']);
    vsphereVolume =
        VsphereVirtualDiskVolumeSource.fromMap(data['vsphereVolume']);
  }
}

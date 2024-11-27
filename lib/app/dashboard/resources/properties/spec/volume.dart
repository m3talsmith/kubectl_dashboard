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
}

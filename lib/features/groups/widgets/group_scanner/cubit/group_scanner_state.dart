

part of 'group_scanner_cubit.dart';

enum GroupScannerStatus { initial, success, failure, remove }

class GroupScannerState extends Equatable {
  const GroupScannerState({
    this.result,
    this.flash = false,
    this.camera,
    this.status = GroupScannerStatus.initial,
  });

  final Barcode? result;
  final bool? flash;
  final CameraFacing? camera;
  final GroupScannerStatus status;

  @override
  List<Object?> get props => [result, status, flash, camera];
}

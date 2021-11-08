import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../data/repositories/group_repository.dart';

part 'group_scanner_state.dart';

class GroupScannerCubit extends Cubit<GroupScannerState> {
  GroupScannerCubit({
    required GroupRepository groupsRepository,
  })  : assert(groupsRepository != null),
        _groupsRepository = groupsRepository,
        super(const GroupScannerState());

  QRViewController? _controller;
  final GroupRepository _groupsRepository;
  StreamSubscription? _qrStream;

  Future<void> initializeQR({required QRViewController newController}) async {
    _controller = newController;
    final flashStatus = await _controller?.getFlashStatus();
    final cameraStatus = (await _controller?.getCameraInfo())!;
    emit(
      GroupScannerState(
        status: GroupScannerStatus.success,
        result: state.result,
        camera: cameraStatus,
        flash: flashStatus,
      ),
    );
    await _qrStream?.cancel();
    _controller!.scannedDataStream.listen(
      (scanData) {
        emit(
          GroupScannerState(
            status: GroupScannerStatus.remove,
            result: scanData,
            camera: state.camera,
            flash: state.flash,
          ),
        );
      },
    );
  }

  Future<bool> isGroupExists({required String groupId}) async {
    final isExist = await _groupsRepository.isGroupExists(groupId: groupId);
    return isExist;
  }

  Future<void> changeFlashStatus() async {
    await _controller?.toggleFlash();
    await updateCameraInfo();
  }

  Future<void> changeCameraPosition() async {
    await _controller?.flipCamera();
    await updateCameraInfo();
  }

  Future<void> updateCameraInfo() async {
    final flashStatus = await _controller?.getFlashStatus();
    final cameraStatus = (await _controller?.getCameraInfo())!;
    emit(
      GroupScannerState(
        status: state.status,
        result: state.result,
        camera: cameraStatus,
        flash: flashStatus,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _qrStream?.cancel();
    _controller?.dispose();
    return super.close();
  }
}

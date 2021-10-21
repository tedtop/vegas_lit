import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vegas_lit/config/palette.dart';

import 'cubit/group_scanner_cubit.dart';

class GroupScanner extends StatelessWidget {
  GroupScanner._({Key key}) : super(key: key);

  static Route route({@required GroupScannerCubit cubit}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'GroupScanner'),
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: GroupScanner._(),
      ),
    );
  }

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 400.0;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: QRView(
              formatsAllowed: [BarcodeFormat.qrcode],
              key: qrKey,
              onQRViewCreated: (QRViewController controller) async {
                await context
                    .read<GroupScannerCubit>()
                    .initializeQR(newController: controller);
              },
              overlay: QrScannerOverlayShape(
                borderColor: Palette.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
              onPermissionSet: (ctrl, p) {
                if (!p) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Permission denied!'),
                    ),
                  );
                }
              },
            ),
          ),
          BlocBuilder<GroupScannerCubit, GroupScannerState>(
            builder: (context, state) {
              switch (state.status) {
                case GroupScannerStatus.remove:
                  return Container();
                  break;
                case GroupScannerStatus.initial:
                  return const SizedBox();
                  break;
                case GroupScannerStatus.success:
                  return Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          iconSize: 25,
                          onPressed: () async {
                            await context
                                .read<GroupScannerCubit>()
                                .changeFlashStatus();
                          },
                          icon: state.flash
                              ? const Icon(Icons.flash_on, color: Palette.cream)
                              : const Icon(Icons.flash_off,
                                  color: Palette.cream),
                        ),
                        IconButton(
                          iconSize: 25,
                          onPressed: () async {
                            await context
                                .read<GroupScannerCubit>()
                                .changeCameraPosition();
                          },
                          icon: describeEnum(state.camera) == 'front'
                              ? const Icon(
                                  Icons.camera_rear,
                                  color: Palette.cream,
                                )
                              : const Icon(
                                  Icons.camera_front,
                                  color: Palette.cream,
                                ),
                        )
                      ],
                    ),
                  );
                  break;
                default:
                  return Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Couldn\'t open the scanner',
                        style: GoogleFonts.nunito(),
                      ),
                    ),
                  );
                  break;
              }
            },
          )
        ],
      ),
    );
  }
}

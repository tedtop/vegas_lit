import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/palette.dart';
import '../cubit/ads_cubit.dart';

class Interstitial extends StatelessWidget {
  const Interstitial._({Key key}) : super(key: key);

  static Route route({@required AdsCubit adsCubit}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      settings: const RouteSettings(name: 'Ads'),
      builder: (context) {
        return BlocProvider(
          create: (_) => adsCubit,
          child: const Interstitial._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
      listener: (context, state) {
        if (state.status == AdsStatus.success) {
          Navigator.of(context).pop();
        }
      },
      // ignore: missing_return
      builder: (context, state) {
        switch (state.status) {
          case AdsStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Palette.cream,
                ),
              ),
            );
            break;
          default:
            return const SizedBox();
        }
      },
    );
  }
}

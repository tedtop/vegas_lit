import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/features/home/cubit/home_cubit.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    Key key,
    this.isHomePage = false,
  }) : super(key: key);

  final bool isHomePage;

  @override
  final Size preferredSize = const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final balanceAmount = isHomePage
        ? context.select(
            (HomeCubit homeCubit) => homeCubit.state.userWallet.accountBalance,
          )
        : 0;

    return AppBar(
      iconTheme: const IconThemeData(color: Palette.cream),
      title: Image.asset(
        Images.topLogo,
        fit: BoxFit.contain,
        height: 80,
      ),
      toolbarHeight: 80,
      actions: isHomePage
          ? [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 9, 10, 11),
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().homeChange(4);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Palette.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Balance',
                            style: GoogleFonts.nunito(
                              color: Palette.cream,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            '\$$balanceAmount',
                            style: GoogleFonts.nunito(
                              color: Palette.cream,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]
          : [],
    );
  }
}

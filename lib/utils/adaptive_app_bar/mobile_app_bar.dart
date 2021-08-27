import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/palette.dart';
import '../../features/home/cubit/home_cubit.dart';

AppBar mobileAppBar({int balanceAmount}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Palette.cream),
    toolbarHeight: 80.0,
    titleSpacing: 0,
    title: Image.asset(
      Images.topLogo,
      fit: BoxFit.contain,
      height: 80,
    ),
    actions: balanceAmount != null
        ? [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Padding(
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
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                '$balanceAmount',
                                style: GoogleFonts.nunito(
                                  color: Palette.cream,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ]
        : [],
  );
}

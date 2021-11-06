import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/extensions.dart';
import '../../../config/palette.dart';
import '../../../data/repositories/device_repository.dart';

part 'sportsbook_state.dart';

class SportsbookCubit extends Cubit<SportsbookState> {
  SportsbookCubit({required DeviceRepository deviceRepository})
      : _deviceRepository = deviceRepository,
        super(
          const SportsbookState.initial(isRulesShown: true),
        );

  final DeviceRepository _deviceRepository;

  Future<void> sportsbookOpen({required String? league}) async {
    final isRulesShow = await _deviceRepository.isRulesShown();
    emit(
      SportsbookState.initial(
        isRulesShown: isRulesShow,
      ),
    );
    final list = <String>[
      'NFL',
      'NBA',
      'PARALYMPICS',
      'OLYMPICS',
      'MLB',
      'NHL',
      'NCAAF',
      'NCAAB',
      'GOLF',
      'CRICKET',
    ];
    if (!kIsWeb) {
      await _deviceRepository.setDefaultLeague(league: 'MLB');
      await _deviceRepository.fetchAndActivateRemote();
    }

    final league = _deviceRepository.fetchRemoteLeague();

    final gameNumberMap = <String, String>{};

    final estTimeZone = ESTDateTime.fetchTimeEST();

    await Future.wait(
      list.map(
        (e) async {
          if (e == 'GOLF' || e == 'OLYMPICS' || e == 'PARALYMPICS') {
            gameNumberMap[e] = 'OFF-SEASON';
          } else {
            gameNumberMap[e] = 'OFFLINE';
          }
        },
      ).toList(),
    );

    emit(
      SportsbookState.opened(
        league: league,
        dropdown: fetchDropdownList(
          gameNumbers: gameNumberMap,
          league: league,
        ),
        gameNumbers: gameNumberMap,
        isRulesShown: state.isRulesShown,
        estTimeZone: estTimeZone,
      ),
    );
  }

  Future<void> sportsbookLeagueChange({required String? league}) async {
    emit(
      SportsbookState.opened(
        league: league,
        dropdown: fetchDropdownList(
          league: league,
          gameNumbers: state.gameNumbers,
        ),
        gameNumbers: state.gameNumbers,
        isRulesShown: state.isRulesShown,
        estTimeZone: state.estTimeZone,
      ),
    );
  }

  void updateLeagueLength({required String league, required int length}) {
    state.gameNumbers[league] = length.toString();

    emit(
      SportsbookState.opened(
        league: state.league,
        dropdown: fetchDropdownList(
          league: state.league,
          gameNumbers: state.gameNumbers,
        ),
        gameNumbers: state.gameNumbers,
        isRulesShown: state.isRulesShown,
        estTimeZone: state.estTimeZone,
      ),
    );
  }

  List<DropdownMenuItem<String>> fetchDropdownList(
      {required Map<String, String> gameNumbers, required String? league}) {
    log('$gameNumbers');
    return <String>[
      'NFL',
      'NBA',
      // 'OLYMPICS',
      // 'PARALYMPICS',
      'MLB',
      'NHL',
      'NCAAF',
      'NCAAB',
      // 'GOLF',
      // 'CRICKET'
    ].map<DropdownMenuItem<String>>(
      (String value) {
        String? length;
        gameNumbers.forEach(
          (key, newValue) {
            if (key == value) {
              if (int.tryParse(newValue) != null) {
                length = '$newValue Games';
              } else {
                length = newValue;
              }
            }
          },
        );

        return DropdownMenuItem<String>(
          value: value,
          child: value == league
              ? Text(
                  '$value ($length)',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Palette.cream,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
              : Text(
                  '$value ($length)',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.nunito(
                    color: Palette.cream,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
        );
      },
    ).toList();
  }
}

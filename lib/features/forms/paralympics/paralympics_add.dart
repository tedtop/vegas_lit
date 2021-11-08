import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../config/extensions.dart';
import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/models/paralympics/paralympics.dart';
import '../../../data/repositories/sport_repository.dart';
import 'cubit/paralympics_add_cubit.dart';

class ParalympicsAddForm extends StatefulWidget {
  const ParalympicsAddForm._({Key? key}) : super(key: key);

  static MaterialPageRoute route() {
    return MaterialPageRoute<void>(
      builder: (context) {
        return BlocProvider(
          create: (context) => ParalympicsAddCubit(
            sportsRepository: context.read<SportRepository>(),
          ),
          child: ParalympicsAddForm._(),
        );
      },
    );
  }

  @override
  _ParalympicsAddFormState createState() => _ParalympicsAddFormState();
}

class _ParalympicsAddFormState extends State<ParalympicsAddForm> {
  final _formKey = GlobalKey<FormState>();

  var startTime = ESTDateTime.fetchTimeEST();
  final venueController = TextEditingController();
  final eventController = TextEditingController();
  String? eventType = 'normal';

  final matchCodeController = TextEditingController();
  String? gameName;
  final playerController = TextEditingController();
  String? playerCountry;
  final rivalController = TextEditingController();
  String? rivalCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Add Paralympic Games',
                        style: Styles.pageTitle,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final newStartTime = await showDatePicker(
                        context: context,
                        initialDate: startTime,
                        firstDate: startTime.subtract(
                          const Duration(days: 10),
                        ),
                        lastDate: startTime.add(
                          const Duration(days: 30),
                        ),
                      );
                      final timeOfDay = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(startTime));

                      if (newStartTime != null && timeOfDay != null) {
                        setState(
                          () {
                            startTime = DateTime(
                              newStartTime.year,
                              newStartTime.month,
                              newStartTime.day,
                              timeOfDay.hour,
                              timeOfDay.minute,
                            ).subtract(
                              const Duration(hours: 13),
                            );
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Palette.lightGrey),
                    ),
                    child: Text(
                      'Change Start Time',
                      style: Styles.normalText,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      '${DateFormat('dd-MM-yy HH:mm').format(startTime)} EST',
                      style: Styles.normalTextBold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: eventController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  cursorColor: Palette.cream,
                  style: Styles.signUpFieldText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    hintStyle: Styles.signUpFieldHint,
                    errorStyle: Styles.authFieldError,
                    filled: true,
                    fillColor: Palette.lightGrey,
                    border: Styles.signUpInputFieldBorder,
                    focusedBorder: Styles.signUpInputFieldFocusedBorder,
                    isDense: true,
                    labelText: 'Event',
                    labelStyle: Styles.signUpFieldHint,
                  ),
                ),
              ),
              DropdownButtonFormField(
                hint: Text(
                  'Event Type',
                  style: Styles.signUpFieldHint,
                ),
                style: Styles.signUpFieldText,
                value: eventType,
                items: <String>[
                  'normal',
                  'bronze',
                  'silver',
                  'gold',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: Styles.normalTextBold));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    eventType = value;
                  });
                },
              ),
              DropdownButtonFormField(
                hint: Text(
                  'Game Name',
                  style: Styles.signUpFieldHint,
                ),
                validator: (String? value) {
                  if (value == null) {
                    return 'Please select a game';
                  }
                  return null;
                },
                style: Styles.signUpFieldText,
                value: gameName,
                items: <String>[
                  'Archery',
                  'Athletics',
                  'Badminton',
                  'Boccia',
                  'Canoe Sprint',
                  'Cycling Road',
                  'Cycling Track',
                  'Equestrian',
                  'Football 5-a-side',
                  'Goalball',
                  'Judo',
                  'Powerlifting',
                  'Rowing',
                  'Shooting',
                  'Sitting Volleyball',
                  'Swimming',
                  'Table Tennis',
                  'Taekwondo',
                  'Triathlon',
                  'Wheelchair Basketball',
                  'Wheelchair Fencing',
                  'Wheelchair Rugby',
                  'Wheelchair Tennis',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: Styles.normalTextBold));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    gameName = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: playerController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  cursorColor: Palette.cream,
                  style: Styles.signUpFieldText,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    hintStyle: Styles.signUpFieldHint,
                    errorStyle: Styles.authFieldError,
                    filled: true,
                    fillColor: Palette.lightGrey,
                    border: Styles.signUpInputFieldBorder,
                    focusedBorder: Styles.signUpInputFieldFocusedBorder,
                    isDense: true,
                    labelText: 'Player',
                    labelStyle: Styles.signUpFieldHint,
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          setState(() {
                            playerCountry = country.countryCode;
                          });
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Palette.lightGrey)),
                    child: Text(
                      'Player Country',
                      style: Styles.normalText,
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    leading: playerCountry != null
                        ? Text(
                            countryFlagFromCode(countryCode: playerCountry!),
                            style: const TextStyle(fontSize: 25),
                          )
                        : Text(
                            'No country selected.',
                            style: Styles.normalTextBold
                                .copyWith(color: Palette.red),
                          ),
                    title: Text(
                      playerCountry ?? '',
                      style: Styles.normalTextBold,
                    ),
                  )),
                ],
              ),
              TextFormField(
                controller: rivalController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                cursorColor: Palette.cream,
                style: Styles.signUpFieldText,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  hintStyle: Styles.signUpFieldHint,
                  errorStyle: Styles.authFieldError,
                  filled: true,
                  fillColor: Palette.lightGrey,
                  border: Styles.signUpInputFieldBorder,
                  focusedBorder: Styles.signUpInputFieldFocusedBorder,
                  isDense: true,
                  labelText: 'Rival',
                  labelStyle: Styles.signUpFieldHint,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          setState(() {
                            rivalCountry = country.countryCode;
                          });
                        },
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Palette.lightGrey)),
                    child: Text(
                      'Rival Country',
                      style: Styles.normalText,
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                    leading: rivalCountry != null
                        ? Text(
                            countryFlagFromCode(countryCode: rivalCountry!),
                            style: const TextStyle(fontSize: 25),
                          )
                        : Text(
                            'No country selected.',
                            style: Styles.normalTextBold
                                .copyWith(color: Palette.red),
                          ),
                    title: Text(
                      rivalCountry ?? '',
                      style: Styles.normalTextBold,
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              BlocConsumer<ParalympicsAddCubit, ParalympicsAddState>(
                listener: (context, state) {
                  if (state.status == ParalympicsAddStatus.complete) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            'Match added.',
                            style: GoogleFonts.nunito(color: Palette.darkGrey),
                          ),
                        ),
                      );
                  }
                },
                builder: (context, state) {
                  if (state.status == ParalympicsAddStatus.loading) {
                    return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Palette.cream,
                          ),
                        ));
                  } else {
                    return SizedBox(
                      width: 110,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                              ),
                              elevation: MaterialStateProperty.all(
                                  Styles.normalElevation),
                              shape:
                                  MaterialStateProperty.all(Styles.smallRadius),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(color: Palette.cream),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Palette.green),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                          child: Text(
                            'Add Game',
                            style: Styles.betSlipButtonText,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                playerCountry != null &&
                                rivalCountry != null) {
                              final olympicGame = ParalympicsGame(
                                event: eventController.text,
                                eventType: eventType,
                                gameName: gameName,
                                isClosed: false,
                                player: playerController.text,
                                playerCountry: playerCountry,
                                rival: rivalController.text,
                                rivalCountry: rivalCountry,
                                startTime: startTime,
                                gameId:
                                    '${gameName!.toUpperCase()}-${playerCountry!.toUpperCase()}-${rivalCountry!.toUpperCase()}-${startTime.toIso8601String()}',
                              );
                              context
                                  .read<ParalympicsAddCubit>()
                                  .addParalympicsGame(game: olympicGame);
                            }
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

String countryFlagFromCode({required String countryCode}) {
  return String.fromCharCode(countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6) +
      String.fromCharCode(countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6);
}

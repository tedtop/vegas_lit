import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/features/authentication/views/sign_up/sign_up.dart';
import 'package:vegas_lit/features/shared_widgets/default_button.dart';
import 'package:vegas_lit/features/shared_widgets/dropdown.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/repositories/user_repository.dart';
import '../../shared_widgets/abstract_card.dart';
import '../../shared_widgets/app_bar/app_bar.dart';
import '../../shared_widgets/bottom_bar.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/avatar/profile_avatar.dart';

class Profile extends StatelessWidget {
  const Profile._({Key key, @required this.currentUserId}) : super(key: key);

  final String currentUserId;

  static Route route({@required String currentUserId}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'Profile'),
      builder: (context) => BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit(
          userRepository: context.read<UserRepository>(),
        )..openProfile(
            currentUserId: currentUserId,
          ),
        child: Profile._(
          currentUserId: currentUserId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: adaptiveAppBar(width: width),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'MY PROFILE',
                  textAlign: TextAlign.center,
                  style: Styles.pageTitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                AbstractCard(
                  padding: const EdgeInsets.fromLTRB(28, 33, 22, 40),
                  widgets: [
                    _AvatarInput(),
                    const SizedBox(height: 30),
                    _UsernameInput(),
                    _EmailInput(),
                    _StateInput(),
                    // _MobileNumberInput(),
                    _EditButton(
                      currentUserId: currentUserId,
                    ),
                  ],
                ),
                const BottomBar()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileAvatar.route();
  }
}

// class _UsernameInput extends StatelessWidget {
//   _UsernameInput({@required this.username})
//       : textInputController = TextEditingController(text: username);
//   final TextEditingController textInputController;
//   final String username;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Text(
//               'Username',
//               style: Styles.signUpFieldDescription,
//             ),
//           ),
//         ),
//         Expanded(
//           child: TextField(
//             inputFormatters: [
//               FilteringTextInputFormatter.deny(RegExp(r'\s')),
//             ],
//             controller: textInputController,
//             cursorColor: Palette.cream,
//             style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.w300,
//             ),
//             key: const Key('profile_usernameInput_textField'),
//             onChanged: print,
//             onSubmitted: (changedUsername) => context
//                 .read<ProfileCubit>()
//                 .changeUsername(username: changedUsername),
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 6,
//                 horizontal: 8,
//               ),
//               hintStyle: GoogleFonts.nunito(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//                 color: Palette.cream,
//               ),
//               filled: true,
//               fillColor: Palette.darkGrey,
//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(4),
//                 ),
//               ),
//               isDense: true,
//               hintText: 'Username',
//               helperText: '',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.userData.username != current.userData.username,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Username',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: state.status == ProfileStatus.loading
                  ? const Center(
                      child: LinearProgressIndicator(
                        color: Palette.cream,
                      ),
                    )
                  : TextField(
                      controller:
                          TextEditingController(text: state.userData.username),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      cursorColor: Palette.cream,
                      style: Styles.signUpFieldText,
                      key: const Key('signUpForm_usernameInput_textField'),
                      onChanged: print,
                      onSubmitted: (changedUsername) => context
                          .read<ProfileCubit>()
                          .changeUsername(username: changedUsername),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 8,
                        ),
                        hintStyle: Styles.signUpFieldHint,
                        errorStyle: Styles.authFieldError,
                        filled: true,
                        fillColor: Palette.lightGrey,
                        border: Styles.signUpInputFieldBorder,
                        isDense: true,
                        hintText: 'Username',
                        helperText: '',
                        //errorText: usernameError(state.userData.username.error),
                        focusedBorder: Styles.signUpInputFieldFocusedBorder,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

// class _EmailInput extends StatelessWidget {
//   _EmailInput({@required this.email})
//       : textInputController = TextEditingController(text: email);
//   final TextEditingController textInputController;
//   final String email;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Text(
//               'Email Address',
//               style: Styles.signUpFieldDescription,
//             ),
//           ),
//         ),
//         Expanded(
//           child: TextField(
//             controller: textInputController,
//             cursorColor: Palette.cream,
//             style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.w300,
//             ),
//             //key: const Key('signUpForm_emailInput_textField'),
//             onChanged: print,
//             onSubmitted: (changedEmail) =>
//                 context.read<ProfileCubit>().changeEmail(email: changedEmail),
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 6,
//                 horizontal: 8,
//               ),
//               filled: true,
//               fillColor: Palette.darkGrey,
//               hintStyle: GoogleFonts.nunito(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//                 color: Palette.cream,
//               ),

//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(4),
//                 ),
//               ),
//               errorStyle: GoogleFonts.nunito(fontSize: 10),
//               isDense: true,
//               hintText: 'Email Address',
//               helperText: '',
//               // errorText: state.email.invalid ? 'Write Correct E-mail' : '',
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.userData.email != current.userData.email,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Email Address',
                  style: Styles.signUpFieldDescription,
                ),
              ),
            ),
            Expanded(
              child: state.status == ProfileStatus.loading
                  ? const Center(
                      child: LinearProgressIndicator(
                        color: Palette.cream,
                      ),
                    )
                  : TextField(
                      controller:
                          TextEditingController(text: state.userData.email),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      cursorColor: Palette.cream,
                      style: Styles.signUpFieldText,
                      key: const Key('signUpForm_emailInput_textField'),
                      onChanged: print,
                      onSubmitted: (changedEmail) => context
                          .read<ProfileCubit>()
                          .changeEmail(email: changedEmail),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 2.5,
                          horizontal: 8,
                        ),
                        hintStyle: Styles.signUpFieldHint,
                        filled: true,
                        fillColor: Palette.lightGrey,
                        border: Styles.signUpInputFieldBorder,
                        errorStyle: Styles.authFieldError,
                        isDense: true,
                        hintText: 'Email Address',
                        helperText: '',
                        //errorText: emailError(state.email.error),
                        focusedBorder: Styles.signUpInputFieldFocusedBorder,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  final stateList = [
    'International',
    'Alabama',
    'Alaska',
    // 'Arizona',
    // 'Arkansas',
    'California',
    'Colorado',
    // 'Connecticut',
    // 'Delaware',
    'District Of Columbia',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    // 'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    // 'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    // 'South Carolina',
    // 'South Dakota',
    // 'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    // 'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.userData.location != current.userData.location,
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Text(
                'State',
                style: Styles.signUpFieldDescription,
              ),
            ),
            Expanded(
              child: state.status == ProfileStatus.loading
                  ? const Center(
                      child: LinearProgressIndicator(
                        color: Palette.cream,
                      ),
                    )
                  : Column(
                      children: [
                        DropDown(
                          initialValue: state.userData.location,
                          isExpanded: true,
                          showUnderline: true,
                          items: stateList,
                          hint: Text(
                            'State',
                            style: GoogleFonts.nunito(),
                          ),
                          onChanged: (String value) => context
                              .read<ProfileCubit>()
                              .changeLocation(location: value),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     const SizedBox(
                        //       width: 5,
                        //     ),
                        //     state.americanState.invalid
                        //         ? Text(
                        //             'Required',
                        //             style: Styles.authFieldError
                        //                 .copyWith(color: Palette.red),
                        //           )
                        //         : Container(),
                        //   ],
                        // ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _EditButton extends StatelessWidget {
  _EditButton({@required this.currentUserId});
  final String currentUserId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      //buildWhen:(previous,current)=>  previous.status!=current.status,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30),
          child: DefaultButton(
            action: () {
              context.read<ProfileCubit>().updateProfile(
                  currentUserId: currentUserId, user: state.userData);
            },
            text: 'Update Profile',
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
// class _StateInput extends StatelessWidget {
//   final TextEditingController textInputController = TextEditingController();

//   GlobalKey _dropdownButtonKey;

//   void openDropdown() {
//     GestureDetector detector;
//     void searchForGestureDetector(BuildContext element) {
//       element.visitChildElements((element) {
//         if (element.widget != null && element.widget is GestureDetector) {
//           detector = element.widget;
//           return false;
//         } else {
//           searchForGestureDetector(element);
//         }

//         return true;
//       });
//     }

//     searchForGestureDetector(_dropdownButtonKey.currentContext);
//     assert(detector != null);

//     detector.onTap();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<ProfileCubit>().state.userData.location;
//     textInputController.text = state;
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Text(
//               'State',
//               style: GoogleFonts.nunito(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   width: 80,
//                   child: TextField(
//                     controller: textInputController,
//                     onChanged: print,
//                     style: GoogleFonts.nunito(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w300,
//                     ),
//                     cursorColor: Palette.cream,
//                     key: const Key('signUpForm_stateInput_textField'),
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(
//                       suffixIconConstraints:
//                           const BoxConstraints(maxHeight: 10, maxWidth: 25),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 6,
//                         horizontal: 8,
//                       ),
//                       filled: true,
//                       fillColor: Palette.darkGrey,
//                       hintStyle: GoogleFonts.nunito(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w300,
//                         color: Palette.cream,
//                       ),
//                       border: const OutlineInputBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(4),
//                           bottomLeft: Radius.circular(4),
//                         ),
//                       ),
//                       isDense: true,
//                       hintText: 'State',
//                       helperText: '',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _MobileNumberInput extends StatelessWidget {
//   final TextEditingController textInputController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final number = context.watch<ProfileCubit>().state.userData.phone;
//     textInputController.text = number.toString();
//     return Row(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Text(
//               'Mobile Number',
//               style: GoogleFonts.nunito(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           child: TextField(
//             autocorrect: false,
//             inputFormatters: [MaskedInputFormater('(###) ###-####')],
//             onChanged: print,
//             controller: textInputController,
//             style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.w300,
//             ),
//             key: const Key('signUpForm_mobileNumberInput_textField'),
//             cursorColor: Palette.cream,
//             keyboardType: TextInputType.phone,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 6,
//                 horizontal: 8,
//               ),
//               hintStyle: GoogleFonts.nunito(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//                 color: Palette.cream,
//               ),
//               filled: true,
//               fillColor: Palette.darkGrey,

//               border: const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(4),
//                 ),
//               ),
//               isDense: true,
//               hintText: 'Mobile Number',
//               helperText: '',
//               // errorText: state.number.invalid ? 'Wrong Mobile Number' : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/repositories/user_repository.dart';
import 'package:vegas_lit/features/profile/cubit/profile_cubit.dart';
import 'package:vegas_lit/features/shared_widgets/abstract_card.dart';
import 'package:vegas_lit/features/shared_widgets/app_bar.dart';

class Profile extends StatelessWidget {
  const Profile._({Key key}) : super(key: key);

  static Route route({@required String currentUserId}) {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: 'Profile'),
      builder: (context) => BlocProvider<ProfileCubit>(
        create: (_) => ProfileCubit(
          userRepository: context.read<UserRepository>(),
        )..openProfile(
            currentUserId: currentUserId,
          ),
        child: const Profile._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
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
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ProfileStatus.opened:
                        return AbstractCard(
                          padding: const EdgeInsets.fromLTRB(28, 33, 22, 40),
                          widgets: [
                            _AvatarInput(),
                            const SizedBox(height: 30),
                            _UsernameInput(),
                            _EmailInput(),
                            _StateInput(),
                            // _MobileNumberInput(),
                            // _EditButton(),
                          ],
                        );
                        break;
                      default:
                        return const CircularProgressIndicator(
                          color: Palette.cream,
                        );
                        break;
                    }
                  },
                ),
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
    final username = context.watch<ProfileCubit>().state.userData.username;
    return ClipPath(
      child: Center(
        child: ClipOval(
          child: Container(
            alignment: Alignment.center,
            color: Palette.darkGrey,
            height: 100.0,
            width: 100.0,
            child: Text(
              username.substring(0, 1).toUpperCase(),
              style: GoogleFonts.nunito(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController textInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final username = context.watch<ProfileCubit>().state.userData.username;
        textInputController.text = username;
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Username',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: textInputController,
                cursorColor: Palette.cream,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                key: const Key('signUpForm_usernameInput_textField'),
                onChanged: print,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  hintStyle: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Palette.cream,
                  ),
                  filled: true,
                  fillColor: Palette.darkGrey,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  isDense: true,
                  hintText: 'Username',
                  helperText: '',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  final TextEditingController textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final email = context.watch<ProfileCubit>().state.userData.email;
    textInputController.text = email;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Email Address',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: textInputController,
            cursorColor: Palette.cream,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: print,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 8,
              ),
              filled: true,
              fillColor: Palette.darkGrey,
              hintStyle: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Palette.cream,
              ),

              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              errorStyle: GoogleFonts.nunito(fontSize: 10),
              isDense: true,
              hintText: 'Email Address',
              helperText: '',
              // errorText: state.email.invalid ? 'Write Correct E-mail' : '',
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class _StateInput extends StatelessWidget {
  final TextEditingController textInputController = TextEditingController();

  GlobalKey _dropdownButtonKey;

  void openDropdown() {
    GestureDetector detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget != null && element.widget is GestureDetector) {
          detector = element.widget;
          return false;
        } else {
          searchForGestureDetector(element);
        }

        return true;
      });
    }

    searchForGestureDetector(_dropdownButtonKey.currentContext);
    assert(detector != null);

    detector.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileCubit>().state.userData.location;
    textInputController.text = state;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'State',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  width: 80,
                  child: TextField(
                    controller: textInputController,
                    onChanged: print,
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    cursorColor: Palette.cream,
                    key: const Key('signUpForm_stateInput_textField'),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 10, maxWidth: 25),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      filled: true,
                      fillColor: Palette.darkGrey,
                      hintStyle: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Palette.cream,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      isDense: true,
                      hintText: 'State',
                      helperText: '',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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

// class _EditButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const Expanded(
//           child: SizedBox(),
//         ),
//         Expanded(
//           child: DefaultButton(
//             action: () {},
//             text: 'EDIT',
//           ),
//         ),
//       ],
//     );
//   }
// }

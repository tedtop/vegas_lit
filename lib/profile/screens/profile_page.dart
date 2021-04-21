import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/assets.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/profile/cubit/profile_cubit.dart';
import 'package:vegas_lit/shared_widgets/abstract_card.dart';
import 'package:vegas_lit/shared_widgets/app_bar.dart';
import 'package:vegas_lit/shared_widgets/default_button.dart';

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
                  height: 35,
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
                            //_PasswordInput(),
                            _EmailInput(),
                            _StateInput(),
                            _MobileNumberInput(),
                            _EditButton(),
                          ],
                        );
                        break;
                      default:
                        return const CircularProgressIndicator();
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
    return const CircleAvatar(
      child: Image(
        image: AssetImage('assets/images/profile_image.png'),
      ),
      radius: 50,
    );
    // Row(
    //   children: [
    //     Expanded(
    //       child: Text(
    //         'Avatar/Pic',
    //         style: GoogleFonts.nunito(
    //           fontSize: 18,
    //           color: Palette.cream,
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: CircleAvatar(
    //         child: Text(
    //           'Change',
    //           style: GoogleFonts.nunito(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 14,
    //           ),
    //         ),
    //         radius: 50,
    //         backgroundImage:
    //             const AssetImage('assets/images/profile_image.png'),
    //       ),
    //     ),
    //   ],
    // );
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
                  // errorText:
                  //     state.username.invalid ? 'Should be less than 10' : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final TextEditingController textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Password',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            controller: textInputController,
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: print,
            obscureText: true,
            cursorColor: Palette.cream,
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
              errorMaxLines: 3,
              errorStyle: GoogleFonts.nunito(
                fontSize: 10,
              ),
              hintText: 'Password',
              helperText: '',
              // errorText: state.password.invalid
              //     ? 'Password should be 8 characters and include at least one number'
              //     : null,
            ),
          ),
        ),
      ],
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
                      // errorText:
                      //     state.americanState.invalid ? 'Wrong State' : null,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 22),
              //   child: Container(
              //     height: 30,
              //     width: 33,
              //     decoration: const BoxDecoration(
              //       color: Palette.green,
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(4),
              //         bottomRight: Radius.circular(4),
              //       ),
              //     ),
              //     child: DropdownButton<String>(
              //       key: _dropdownButtonKey,
              //       items: [
              //         DropdownMenuItem(
              //           value: '1',
              //           child: Text('1'),
              //         ),
              //         DropdownMenuItem(
              //           value: '2',
              //           child: Text('2'),
              //         ),
              //         DropdownMenuItem(
              //           value: '3',
              //           child: Text('3'),
              //         ),
              //       ],
              //       onChanged: (String value) {},
              //     ),
              //     clipBehavior: Clip.antiAliasWithSaveLayer,
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileNumberInput extends StatelessWidget {
  final TextEditingController textInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final number = context.watch<ProfileCubit>().state.userData.phone;
    textInputController.text = number.toString();
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Mobile Number',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextField(
            autocorrect: false,
            inputFormatters: [MaskedInputFormater('(###) ###-####')],
            onChanged: print,
            controller: textInputController,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
            key: const Key('signUpForm_mobileNumberInput_textField'),
            cursorColor: Palette.cream,
            keyboardType: TextInputType.phone,
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
              hintText: 'Mobile Number',
              helperText: '',
              // errorText: state.number.invalid ? 'Wrong Mobile Number' : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          child: DefaultButton(
            action: () {},
            text: 'EDIT',
          ),
        ),
      ],
    );
  }
}

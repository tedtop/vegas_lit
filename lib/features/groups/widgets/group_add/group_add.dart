import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import '../../../../config/extensions.dart';
import '../../../../config/palette.dart';
import '../../../../config/styles.dart';
import '../../../../data/models/group.dart';
import '../../../../data/repositories/groups_repository.dart';
import '../../../home/home.dart';
import 'cubit/group_add_cubit.dart';

class GroupAdd extends StatefulWidget {
  GroupAdd._({Key? key}) : super(key: key);

  static MaterialPageRoute route(
      {required HomeCubit homeCubit,
      required StorageRepository storageRepository}) {
    return MaterialPageRoute<void>(
      builder: (context) {
        return BlocProvider.value(
          value: homeCubit,
          child: BlocProvider(
            create: (context) => GroupAddCubit(
              groupsRepository: context.read<GroupsRepository>(),
              storageRepository: storageRepository,
            ),
            child: GroupAdd._(),
          ),
        );
      },
    );
  }

  @override
  _GroupAddState createState() => _GroupAddState();
}

class _GroupAddState extends State<GroupAdd> {
  final _formKey = GlobalKey<FormState>();

  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();
  bool? _isUnlimitedSize = true;
  bool? _isPublic = true;
  int? _userLimit;

  @override
  Widget build(BuildContext context) {
    final userData = context.select((HomeCubit cubit) => cubit.state.userData!);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'NEW GROUP',
          style: Styles.pageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Admin',
                style: Styles.groupFieldHeading,
              ),
              Text(
                'As the creator of this group, you are the admin.',
                style: Styles.groupFieldDescription,
              ),
              const SizedBox(height: 10),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Palette.lightGrey,
                  border: Border.all(color: Palette.cream, width: 0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userData.username!,
                    style: Styles.normalText,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Group Name',
                style: Styles.groupFieldHeading,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: Styles.normalText,
                decoration: const InputDecoration(
                  hintText: 'Group Name',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 10,
                  ),
                  fillColor: Palette.lightGrey,
                  filled: true,
                  border: Styles.groupFieldBorder,
                  focusedBorder: Styles.groupFieldFocusedBorder,
                ),
                controller: _groupNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Group Name.';
                  } else if (!RegExp(r'^[a-zA-Z0-9_ \-=,\.]+$')
                      .hasMatch(value)) {
                    return 'Please enter a valid Group Name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Group Type',
                style: Styles.groupFieldHeading,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          value: true,
                          groupValue: _isPublic,
                          onChanged: (bool? val) => setState(() {
                            _isPublic = val;
                          }),
                          title: Text(
                            'Public',
                            style: Styles.normalText,
                          ),
                          activeColor: Palette.green,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: RadioListTile(
                          value: false,
                          groupValue: _isPublic,
                          onChanged: (bool? val) => setState(() {
                            _isPublic = val;
                          }),
                          title: Text(
                            'Private',
                            style: Styles.normalText,
                          ),
                          activeColor: Palette.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  BlocBuilder<GroupAddCubit, GroupAddState>(
                    builder: (context, state) {
                      if (state.avatarFile != null)
                        return Stack(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: Image.file(state.avatarFile!),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  context.read<GroupAddCubit>().pickAvatar();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Palette.darkGrey,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Palette.cream)),
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.edit,
                                        color: Palette.cream,
                                        size: 12,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Edit',
                                        style: GoogleFonts.nunito(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      return InkWell(
                        onTap: () {
                          context.read<GroupAddCubit>().pickAvatar();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Palette.cream),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Upload Icon',
                              style: Styles.normalTextBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Group Description or Motto',
                style: Styles.groupFieldHeading,
              ),
              Text(
                'Maximum 160 characters',
                style: Styles.groupFieldDescription,
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Group Description or Motto',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 10,
                  ),
                  fillColor: Palette.lightGrey,
                  filled: true,
                  border: Styles.groupFieldBorder,
                  focusedBorder: Styles.groupFieldFocusedBorder,
                ),
                controller: _groupDescriptionController,
                validator: (value) {
                  if (value!.length > 160) {
                    return 'Maximum 160 characters allowed!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Text('Maximum Size', style: Styles.groupFieldHeading),
              RadioListTile(
                value: true,
                groupValue: _isUnlimitedSize,
                onChanged: (bool? val) => setState(
                  () {
                    _isUnlimitedSize = val;
                  },
                ),
                title: Text(
                  'Unlimited Members',
                  style: Styles.normalText,
                ),
              ),
              RadioListTile(
                value: false,
                groupValue: _isUnlimitedSize,
                onChanged: (bool? val) => setState(
                  () {
                    _isUnlimitedSize = val;
                  },
                ),
                title: Row(
                  children: [
                    Text('Limit Members to: ', style: Styles.normalText),
                    SizedBox(
                      width: 80,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Size',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          fillColor: Palette.lightGrey,
                          filled: true,
                          isDense: true,
                          border: Styles.groupFieldBorder,
                          focusedBorder: Styles.groupFieldFocusedBorder,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        validator: (value) {
                          if (!_isUnlimitedSize!) {
                            if (value!.isEmpty) {
                              return 'Required';
                            } else if (int.tryParse(value)! <= 1) {
                              return 'Invalid value';
                            } else if (int.parse(value) > 250) {
                              return 'Maximum 250 members allowed';
                            }
                          }
                          return null;
                        },
                        onTap: () {
                          setState(() {
                            _isUnlimitedSize = false;
                          });
                        },
                        onChanged: (val) {
                          setState(() {
                            _userLimit = int.tryParse(val);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<GroupAddCubit, GroupAddState>(
                listener: (context, state) {
                  if (state.status == GroupAddStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Group Created Successfully!'),
                        ),
                      );
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case GroupAddStatus.initial:
                      return userData.groups!.length >= 10
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Text(
                                  'You have reached the limit of creating groups.',
                                  style: GoogleFonts.nunito(fontSize: 16),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 174,
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
                                      shape: MaterialStateProperty.all(
                                          Styles.smallRadius),
                                      textStyle: MaterialStateProperty.all(
                                        const TextStyle(color: Palette.cream),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Palette.green),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                  child: Text(
                                    'CREATE GROUP',
                                    style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<GroupAddCubit>().addGroup(
                                            group: Group(
                                              adminId: userData.uid,
                                              adminName: userData.username,
                                              avatarUrl: null,
                                              createdBy: userData.uid,
                                              createdAt:
                                                  ESTDateTime.fetchTimeEST(),
                                              description:
                                                  _groupDescriptionController
                                                      .text,
                                              isPublic: _isPublic,
                                              name: _groupNameController.text,
                                              userLimit: _isUnlimitedSize!
                                                  ? 0
                                                  : _userLimit,
                                              users: {userData.uid: true},
                                              id: '${_groupNameController.text}-${ESTDateTime.fetchTimeEST().toString()}-${userData.uid}',
                                              isUnlimited: _isUnlimitedSize,
                                            ),
                                          );
                                    }
                                  },
                                ),
                              ),
                            );

                    case GroupAddStatus.loading:
                      return const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Palette.cream,
                            ),
                          ));
                    case GroupAddStatus.success:
                      return Container(
                        height: 80,
                        width: 360,
                        color: Palette.green,
                        child: Center(
                          child: Text(
                            'GROUP CREATED',
                            style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

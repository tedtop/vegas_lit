import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import 'cubit/group_edit_cubit.dart';

class GroupEdit extends StatefulWidget {
  GroupEdit._({Key key, @required this.group}) : super(key: key);

  final Group group;

  static MaterialPageRoute route(
      {@required StorageRepository storageRepository, @required Group group}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) => GroupEditCubit(
            groupsRepository: context.read<GroupsRepository>(),
            storageRepository: storageRepository,
          ),
          child: GroupEdit._(group: group),
        );
      },
    );
  }

  @override
  _GroupEditState createState() => _GroupEditState();
}

class _GroupEditState extends State<GroupEdit> {
  final _formKey = GlobalKey<FormState>();
  final _groupDescriptionController = TextEditingController();
  bool _isUnlimitedSize = true;
  bool _isPublic = true;
  int _userLimit;

  @override
  void initState() {
    _groupDescriptionController.text = widget.group.description;
    _isUnlimitedSize = widget.group.isUnlimited;
    _isPublic = widget.group.isPublic;
    _userLimit = widget.group.userLimit;
    super.initState();
  }

  @override
  void dispose() {
    _groupDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.group.name.toUpperCase(),
          style: Styles.pageTitle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
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
                          onChanged: (val) => setState(() {
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
                          onChanged: (val) => setState(() {
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
                  BlocBuilder<GroupEditCubit, GroupEditState>(
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
                                child: Image.file(state.avatarFile),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  context.read<GroupEditCubit>().pickAvatar();
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
                          context.read<GroupEditCubit>().pickAvatar();
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
                  if (value.length > 160) {
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
                onChanged: (val) => setState(
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
                onChanged: (val) => setState(
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
                          if (!_isUnlimitedSize) {
                            if (value.isEmpty) {
                              return 'Required';
                            } else if (int.tryParse(value) <= 1) {
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
              BlocConsumer<GroupEditCubit, GroupEditState>(
                listener: (context, state) {
                  if (state.status == GroupEditStatus.success) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Group Updated Successfully!'),
                        ),
                      );
                    Navigator.of(context).pop();
                  }
                },
                builder: (context, state) {
                  switch (state.status) {
                    case GroupEditStatus.initial:
                      return DefaultButton(
                        text: 'UPDATE GROUP',
                        action: () {
                          if (_formKey.currentState.validate()) {
                            context.read<GroupEditCubit>().editGroup(
                                  group: Group(
                                    adminId: widget.group.adminId,
                                    adminName: widget.group.adminName,
                                    avatarUrl: widget.group.avatarUrl,
                                    createdBy: widget.group.createdBy,
                                    createdAt: widget.group.createdAt,
                                    description:
                                        _groupDescriptionController.text,
                                    isPublic: _isPublic,
                                    name: widget.group.name,
                                    userLimit:
                                        _isUnlimitedSize ? 0 : _userLimit,
                                    users: widget.group.users,
                                    id: widget.group.id,
                                    isUnlimited: _isUnlimitedSize,
                                  ),
                                );
                          }
                        },
                      );
                      break;
                    case GroupEditStatus.loading:
                      return const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Palette.cream,
                            ),
                          ));
                    case GroupEditStatus.success:
                      return Container(
                        height: 80,
                        width: 360,
                        color: Palette.green,
                        child: Center(
                          child: Text(
                            'GROUP UPDATED',
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

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
    this.color = Palette.green,
    this.elevation = Styles.normalElevation,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final Function action;
  final Color color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return SizedBox(
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
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(Styles.smallRadius),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Palette.cream),
              ),
              backgroundColor: MaterialStateProperty.all(color),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          child: Text(
            text,
            style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: action,
        ),
      ),
    );
  }
}

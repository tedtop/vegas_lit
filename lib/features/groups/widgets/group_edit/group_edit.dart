import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/group.dart';
import 'package:vegas_lit/data/repositories/groups_repository.dart';
import 'package:vegas_lit/data/repositories/storage_repository.dart';

import 'cubit/group_edit_cubit.dart';

class GroupEdit extends StatefulWidget {
  GroupEdit._({Key? key, required this.group}) : super(key: key);

  final Group? group;

  static MaterialPageRoute route(
      {required StorageRepository storageRepository, required Group? group}) {
    return MaterialPageRoute<void>(
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
  final _groupNameController = TextEditingController();
  final _groupDescriptionController = TextEditingController();
  bool? _isUnlimitedSize = true;
  bool? _isPublic = true;
  int? _userLimit;

  @override
  void initState() {
    _groupNameController.text = widget.group!.name!;
    _groupDescriptionController.text = widget.group!.description!;
    _isUnlimitedSize = widget.group!.isUnlimited;
    _isPublic = widget.group!.isPublic;
    _userLimit = widget.group!.userLimit;
    super.initState();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'EDIT GROUP',
          style: Styles.normalTextBold,
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
                  BlocBuilder<GroupEditCubit, GroupEditState>(
                    builder: (context, state) {
                      if (widget.group!.avatarUrl != null ||
                          state.avatarFile != null)
                        return Stack(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                child: state.avatarFile != null
                                    ? Image.file(state.avatarFile!)
                                    : CachedNetworkImage(
                                        imageUrl: widget.group!.avatarUrl!,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SizedBox(
                                            width: 35,
                                            height: 35,
                                            child: CircularProgressIndicator(
                                              color: Palette.cream,
                                            ),
                                          ),
                                        ),
                                      ), //Image for web configuration.
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
                  if (value!.length > 160) {
                    return 'Maximum 160 characters allowed!';
                  }
                  return null;
                },
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
                                elevation: MaterialStateProperty.all(
                                    Styles.normalElevation),
                                shape: MaterialStateProperty.all(
                                    Styles.smallRadius),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(color: Palette.cream),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Palette.green),
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text(
                              'UPDATE GROUP',
                              style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<GroupEditCubit>().editGroup(
                                      group: Group(
                                        adminId: widget.group!.adminId,
                                        adminName: widget.group!.adminName,
                                        avatarUrl: widget.group!.avatarUrl,
                                        createdBy: widget.group!.createdBy,
                                        createdAt: widget.group!.createdAt,
                                        description:
                                            _groupDescriptionController.text,
                                        isPublic: _isPublic,
                                        name: _groupNameController.text,
                                        userLimit:
                                            _isUnlimitedSize! ? 0 : _userLimit,
                                        users: widget.group!.users,
                                        id: widget.group!.id,
                                        isUnlimited: _isUnlimitedSize,
                                      ),
                                    );
                              }
                            },
                          ),
                        ),
                      );
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/palette.dart';
import '../../bet_slip/bet_slip.dart';

import '../home.dart';

class InteractiveNavItem extends StatelessWidget {
  InteractiveNavItem({this.index, this.selected, this.title});
  final String title;
  final bool selected;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BetSlipCubit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.5),
        child: GestureDetector(
          child: InteractiveText(text: title, selected: selected),
          onTap: () => context.read<HomeCubit>().homeChange(index),
        ),
      ),
    );
  }
}

class InteractiveText extends StatefulWidget {
  const InteractiveText({@required this.text, @required this.selected});

  final String text;
  final bool selected;

  @override
  InteractiveTextState createState() => InteractiveTextState();
}

class InteractiveTextState extends State<InteractiveText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    _hovering = widget.selected;
    return MouseRegion(
      onHover: (_) => _hovered(true),
      onExit: (_) => _hovered(false),
      child: Text(
        widget.text,
        style: _hovering ? onHoveredTextStyle : onNotHoveredTextStyle,
      ),
    );
  }

  void _hovered(bool hovered) {
    setState(() {
      _hovering = hovered;
    });
  }
}

var onHoveredTextStyle = const TextStyle(
    fontSize: 18, color: Palette.red, fontWeight: FontWeight.w500);
var onNotHoveredTextStyle = const TextStyle(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);

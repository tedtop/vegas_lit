import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegas_lit/bet_slip/bet_slip.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:universal_html/html.dart' as html;
import 'package:vegas_lit/home/cubit/home_cubit.dart';

class InteractiveNavItem extends StatelessWidget {
  final String title;
  final bool selected;
  final int index;
  InteractiveNavItem({this.index, this.selected, this.title});

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
  final String text;
  final bool selected;

  const InteractiveText({@required this.text, @required this.selected});

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

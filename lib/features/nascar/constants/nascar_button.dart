import 'package:flutter/material.dart';
import 'package:vegas_lit/features/nascar/constants/constants.dart';

class NascarButton extends StatelessWidget {
  const NascarButton(
      {Key? key,
      required this.text,
      this.action,
      this.color = NascarPalette.blue})
      : super(key: key);

  final String text;
  final void Function()? action;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      width: 280,
      height: 36,
      child: TextButton(
        onPressed: action,
        child: Text(
          text,
          style: NascarStyles.buttonText,
        ),
      ),
    );
  }
}

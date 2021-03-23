import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.text,
    @required this.action,
    this.color = Palette.green,
    this.elevation = Styles.dropShadow,
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
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
        child: RaisedButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: elevation,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            text,
            style: Styles.greenButtonText,
          ),
          shape: Styles.buttonRadius,
          textColor: Palette.cream,
          color: color,
          onPressed: action,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';

class AbstractCard extends StatelessWidget {
  const AbstractCard({
    Key key,
    @required this.widgets,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12.5,
      vertical: 12.0,
    ),
  }) : super(key: key);

  final List<Widget> widgets;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        width: 390,
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.cream,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          color: Palette.lightGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: padding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: crossAxisAlignment,
                children: widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

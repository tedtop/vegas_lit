import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/palette.dart';

class TextBar extends StatelessWidget {
  const TextBar({
    Key key,
    @required this.text,
    @required this.textList,
    @required this.onPress,
  }) : super(key: key);

  final String text;
  final List<String> textList;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: Card(
        // elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          color: Palette.green,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 40,
          width: double.infinity,
          child: Center(
            child: DropdownButton<String>(
              dropdownColor: Palette.green,
              isDense: true,
              value: text,
              icon: const Icon(
                FontAwesome.angle_down,
                color: Palette.cream,
              ),
              isExpanded: true,
              underline: Container(
                height: 0,
              ),
              style: GoogleFonts.nunito(
                fontSize: 18,
              ),
              onChanged: onPress,
              items: textList.map<DropdownMenuItem<String>>((element) {
                return DropdownMenuItem<String>(
                  child: Text(element),
                  value: element,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

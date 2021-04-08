import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';

class PageNumberView extends StatefulWidget {
  final int pages;

  PageNumberView({this.pages});

  @override
  _PageNumberViewState createState() => _PageNumberViewState();
}

class _PageNumberViewState extends State<PageNumberView> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (selectedPage > 1) selectedPage -= 1;
                    });
                  },
                  icon: const Icon(FontAwesome.angle_left),
                )),
            NumberPicker(
              minValue: 1,
              maxValue: widget.pages,
              value: selectedPage,
              onChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              axis: Axis.horizontal,
              itemCount: 5,
              selectedTextStyle: Styles.greenText,
              textStyle: Styles.normalText,
              haptics: true,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (selectedPage < widget.pages) selectedPage += 1;
                    });
                  },
                  icon: const Icon(FontAwesome.angle_right),
                )),
          ],
        ),
        mobile: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedPage > 1) selectedPage -= 1;
                  });
                },
                icon: const Icon(FontAwesome.angle_left),
              ),
            ),
            NumberPicker(
              minValue: 1,
              maxValue: widget.pages,
              value: selectedPage,
              onChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              axis: Axis.horizontal,
              itemCount: 3,
              selectedTextStyle: Styles.greenText,
              textStyle: Styles.normalText,
              haptics: true,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (selectedPage < widget.pages) selectedPage += 1;
                    });
                  },
                  icon: const Icon(FontAwesome.angle_right),
                )),
          ],
        ));
  }
}

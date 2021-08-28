import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';

typedef OnNumberTap = void Function(int number);

class PageNumberView extends StatefulWidget {
  PageNumberView({this.pages});

  final int pages;

  @override
  _PageNumberViewState createState() => _PageNumberViewState();
}

class _PageNumberViewState extends State<PageNumberView> {
  int selectedPage = 1;
  void updatePageNumber(int pageNumber) {
    setState(() {
      selectedPage = pageNumber;
    });
    return;
  }

  Widget ellipsisIcon() {
    return const Icon(
      FontAwesome.ellipsis_h,
      color: Palette.cream,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageList = List<int>.generate(widget.pages, (i) => i + 1);
    if (widget.pages <= 0) return Container();
    if (widget.pages <= 7)
      return Row(
        children: pageList.map((pageNumber) {
          return PageNumberWidget(
            number: pageNumber,
            selected: pageNumber == selectedPage ? true : false,
            changeNumber: updatePageNumber,
          );
        }).toList(),
      );
    if (selectedPage >= 1 && selectedPage <= 3)
      return Row(
        children: [
          ...pageList.getRange(0, 4).map((pageNumber) {
            return PageNumberWidget(
              number: pageNumber,
              selected: pageNumber == selectedPage ? true : false,
              changeNumber: updatePageNumber,
            );
          }).toList(),
          ellipsisIcon(),
          ...pageList
              .getRange(widget.pages - 1, widget.pages)
              .map((pageNumber) {
            return PageNumberWidget(
              number: pageNumber,
              selected: pageNumber == selectedPage ? true : false,
              changeNumber: updatePageNumber,
            );
          }).toList(),
        ],
      );
    if (selectedPage > widget.pages - 3 && selectedPage <= widget.pages)
      return Row(
        children: [
          ...pageList.getRange(0, 2).map((pageNumber) {
            return PageNumberWidget(
              number: pageNumber,
              selected: pageNumber == selectedPage ? true : false,
              changeNumber: updatePageNumber,
            );
          }).toList(),
          ellipsisIcon(),
          ...pageList
              .getRange(widget.pages - 4, widget.pages)
              .map((pageNumber) {
            return PageNumberWidget(
              number: pageNumber,
              selected: pageNumber == selectedPage ? true : false,
              changeNumber: updatePageNumber,
            );
          }).toList(),
        ],
      );
    return Row(
      children: [
        PageNumberWidget(
          number: 1,
          selected: 1 == selectedPage ? true : false,
          changeNumber: updatePageNumber,
        ),
        ellipsisIcon(),
        ...pageList
            .getRange(selectedPage - 2, selectedPage + 1)
            .map((pageNumber) {
          return PageNumberWidget(
            number: pageNumber,
            selected: pageNumber == selectedPage ? true : false,
            changeNumber: updatePageNumber,
          );
        }).toList(),
        ellipsisIcon(),
        PageNumberWidget(
          number: widget.pages,
          selected: widget.pages == selectedPage ? true : false,
          changeNumber: updatePageNumber,
        ),
      ],
    );
  }
}

class PageNumberWidget extends StatelessWidget {
  PageNumberWidget({this.number, this.changeNumber, this.selected = false});
  final int number;
  final bool selected;
  final OnNumberTap changeNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => changeNumber(number),
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: selected ? Palette.green : Palette.cream,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '$number',
              style: selected ? Styles.normalText : Styles.greenText,
            ),
          ),
        ),
      ),
    );
  }
}

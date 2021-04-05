import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDown<T> extends StatefulWidget {
  final List<T> items;
  final List<Widget> customWidgets;
  final T initialValue;
  final Widget hint;
  final Function onChanged;
  final bool isExpanded;
  final bool isCleared;
  final bool showUnderline;

  DropDown({
    @required this.items,
    this.customWidgets,
    this.initialValue,
    this.hint,
    this.onChanged,
    this.isExpanded = false,
    this.isCleared = false,
    this.showUnderline = true,
  })  : assert(items != null && !(items is Widget)),
        assert((customWidgets != null)
            ? items.length == customWidgets.length
            : (customWidgets == null));

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState<T> extends State<DropDown<T>> {
  T selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton<T>(
      isExpanded: widget.isExpanded,
      onChanged: (T value) {
        setState(() => selectedValue = value);
        if (widget.onChanged != null) widget.onChanged(value);
      },
      value: widget.isCleared ? null : selectedValue,
      items: widget.items.map<DropdownMenuItem<T>>(buildDropDownItem).toList(),
      hint: widget.hint,
    );

    return widget.showUnderline
        ? dropdown
        : DropdownButtonHideUnderline(child: dropdown);
  }

  DropdownMenuItem<T> buildDropDownItem(T item) => DropdownMenuItem<T>(
        child: (widget.customWidgets != null)
            ? widget.customWidgets[widget.items.indexOf(item)]
            : Text(
                item.toString(),
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w300,
                ),
              ),
        value: item,
      );
}

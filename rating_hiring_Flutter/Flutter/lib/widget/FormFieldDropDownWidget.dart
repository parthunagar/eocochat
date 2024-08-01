import 'package:flutter/material.dart';
import 'package:rentors/model/DropDownItem.dart';

class FormFieldDropDownWidget extends StatefulWidget {
  final String hint;

  final List<DropDownItem> dropdownItems;

  final ValueChanged<DropDownItem> callback;
  final DropDownItem selected;

  FormFieldDropDownWidget(
      {this.hint, this.dropdownItems, this.callback, this.selected});

  @override
  State<StatefulWidget> createState() {
    return new FormFieldDropDownWidgetState();
  }
}

class FormFieldDropDownWidgetState extends State<FormFieldDropDownWidget> {
  List<DropdownMenuItem<DropDownItem>> _dropdownMenuItems;
  DropDownItem _selectedItem;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(widget.dropdownItems);
    if (_dropdownMenuItems.isNotEmpty && widget.selected == null) {
      _selectedItem = _dropdownMenuItems.first.value;
    } else if (widget.selected != null) {
      _selectedItem = widget.selected;
    }
  }

  List<DropdownMenuItem<DropDownItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<DropDownItem>> items = List();
    for (DropDownItem listItem in listItems) {
      items.add(
        DropdownMenuItem<DropDownItem>(
          child: Text(listItem.value),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Theme.of(context).hintColor)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
                widget.callback(value);
              }),
        ));
  }
}

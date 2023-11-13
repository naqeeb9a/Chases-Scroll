import 'dart:convert';

import 'package:chases_scroll/src/models/event_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

//for event ticket type

class DropDownEventType extends StatefulWidget {
  final String? typeValue;

  final List<ProductTypeData> typeList;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  const DropDownEventType(
      {super.key,
      this.typeValue,
      required this.typeList,
      this.onChanged,
      this.onSaved});

  @override
  State<DropDownEventType> createState() => _DropDownEventTypeState();
}

class DropDownListView extends StatefulWidget {
  final String? typeValue;

  final List<Map<String, String>> typeList;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  const DropDownListView(
      {super.key,
      this.typeValue,
      required this.typeList,
      this.onChanged,
      this.onSaved});

  @override
  State<DropDownListView> createState() => _DropDownListViewState();
}

class DropDownListViewString extends StatefulWidget {
  final String? typeValue;

  final List<String> typeList;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  const DropDownListViewString(
      {super.key,
      this.typeValue,
      required this.typeList,
      this.onChanged,
      this.onSaved});

  @override
  State<DropDownListViewString> createState() => _DropDownListViewStringState();
}

class _DropDownEventTypeState extends State<DropDownEventType> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        widget.typeValue.toString(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),

      items: widget.typeList
          .map((item) => DropdownMenuItem<String>(
                value: jsonEncode(item),
                child: Text(
                  "${item.ticketType} ${item.ticketPrice}",
                  style: const TextStyle(fontSize: 14),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select option';
        }
        return null;
      },
      onChanged: widget.onChanged,
      // onChanged: (value) {
      //   //Do something when changing the item if you want.
      //   setState(() {
      //     eventTypeValue = value;
      //     print(eventTypeValue);
      //   });
      // },
      onSaved: widget.onSaved,
    );
  }
}

class _DropDownListViewState extends State<DropDownListView> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        widget.typeValue.toString(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),

      items: widget.typeList
          .map((item) => DropdownMenuItem<String>(
                value: item['id'],
                child: Text(
                  item['name'].toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Event Type';
        }
        return null;
      },
      onChanged: widget.onChanged,
      // onChanged: (value) {
      //   //Do something when changing the item if you want.
      //   setState(() {
      //     eventTypeValue = value;
      //     print(eventTypeValue);
      //   });
      // },
      onSaved: widget.onSaved,
    );
  }
}

class _DropDownListViewStringState extends State<DropDownListViewString> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xffE0E0E0), width: 1),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        widget.typeValue.toString(),
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),
      items: widget.typeList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select option';
        }
        return null;
      },
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}

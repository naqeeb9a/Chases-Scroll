import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownListStringView extends StatefulWidget {
  final String? typeValue;

  final List<String> typeList;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSaved;

  const DropDownListStringView(
      {super.key,
      this.typeValue,
      required this.typeList,
      this.onChanged,
      this.onSaved});

  @override
  State<DropDownListStringView> createState() => _DropDownListStringViewState();
}

class _DropDownListStringViewState extends State<DropDownListStringView> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
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
      icon: const Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 20,
        color: Colors.black45,
      ),
      iconSize: 30,
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.only(left: 0, right: 5),
      dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 1.5)),
      items: widget.typeList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item.toString(),
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

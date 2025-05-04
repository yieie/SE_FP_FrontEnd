import 'package:flutter/material.dart';

class BasicWebDropdownbuttonFormField extends StatelessWidget{
  final List<DropdownMenuItem<String>>? items;
  final Widget? hint;
  final ValueChanged? onChanged;
  final String? value;

  const BasicWebDropdownbuttonFormField({super.key,required this.items, this.hint ,required this.onChanged,this.value});

  @override
  Widget build(BuildContext context){
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(0x39,0x38,0x38,1) ,width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,width: 2),
          borderRadius: BorderRadius.circular(10)
        )
      ),
      value: value,
      hint: hint,
      items: items, 
      onChanged: onChanged
    );
  }
  
}
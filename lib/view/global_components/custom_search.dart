import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  final Function(String) onChangedFunc;
  const CustomSearch({required this.onChangedFunc, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style:
          Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
      onChanged: onChangedFunc,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

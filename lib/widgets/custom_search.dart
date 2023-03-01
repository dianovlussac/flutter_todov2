import 'package:flutter/material.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({Key? key, required this.onChanged}) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(255, 201, 198, 198),
              offset: Offset(0, 5),
              blurRadius: 8),
        ],
      ),
      child: TextFormField(
        onChanged: (String val) {
          onChanged(val);
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search Task here...",
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color.fromARGB(255, 167, 163, 163),
          ),
        ),
      ),
    );
  }
}

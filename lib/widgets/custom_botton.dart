import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBotton extends StatelessWidget {
   CustomBotton({super.key, required this.text, this.onTap})  ;
  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        height: 50,
        child:  Center(
          child: Text(
            text ,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

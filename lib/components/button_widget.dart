import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class buttonWidget extends StatefulWidget {
  buttonWidget({super.key, required this.title,
    this.onPressed,
    required  this.textColor,
    required this.onHoverColor,
    required this.colors,
    required this.width});
  Color textColor;
  VoidCallback? onPressed;
  String title;
  List<Color> onHoverColor;
  List<Color> colors;
  double width;
  @override
  State<buttonWidget> createState() => _buttonWidgetState();
}

class _buttonWidgetState extends State<buttonWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
    height: 40,
    width: widget.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: widget.colors),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.title,
        style: GoogleFonts.publicSans().copyWith(
            color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
  );
  }
}

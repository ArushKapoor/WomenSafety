import 'package:flutter/material.dart';

class MapBottomSheetBuilder extends StatelessWidget {
  final double width;
  final double height;
  MapBottomSheetBuilder({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: height * 0.5,
        child: Center(
          child: Icon(Icons.map),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

typedef OnSelect = void Function(int index);

class PagePicker extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final OnSelect select;
  const PagePicker(
      {super.key,
      this.minValue = 0,
      this.maxValue = 100,
      this.initialValue = 0,
      required this.select});

  @override
  PagePickerState createState() => PagePickerState();
}

class PagePickerState extends State<PagePicker> {
  late int _selectedNumber;

  @override
  void initState() {
    super.initState();
    _selectedNumber = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(100, 100),
      child: ListView.builder(
        itemExtent: 32,
        scrollDirection: Axis.vertical,
        itemCount: widget.maxValue - widget.minValue + 1,
        itemBuilder: (BuildContext context, int index) {
          final number = widget.minValue + index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedNumber = number;
              });
              widget.select(number);
            },
            child: Center(
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 20.0,
                  color: number == _selectedNumber
                      ? Colors.lightBlueAccent
                      : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

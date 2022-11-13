// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:nappy_mobile/utilities/constants.dart';

class ThemeColorPicker extends StatelessWidget {
  final Color activeColor;
  final void Function(Color color) onChanged;
  const ThemeColorPicker({
    Key? key,
    required this.onChanged,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getPicker(context);
  }

  Widget getPicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlockPicker(
        pickerColor: kPrimaryColor,
        availableColors: const [
          kPrimaryColor,
          Colors.red,
          Colors.deepPurple,
          Colors.indigo,
          Colors.blue,
          Colors.lightBlue,
          Colors.cyan,
          Colors.teal,
          Colors.lightGreen,
          Colors.lime,
          Colors.yellow,
          Colors.amber,
          Colors.orange,
          Colors.deepOrange,
          Colors.brown,
          Colors.grey,
          Colors.black,
        ],
        layoutBuilder: _layoutBuilder,
        itemBuilder: (color, isCurrentColor, changeColor) {
          return _ThemeColorPickerItem(
            color: color,
            isCurrentColor: isCurrentColor,
            changeColor: changeColor,
          );
        },
        onColorChanged: (color) => onChanged(color),
      ),
    );
  }

  Widget _layoutBuilder(BuildContext _, List<Color> colors, PickerItem child) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          return child(colors[index]);
        },
      ),
    );
  }
}

class _ThemeColorPickerItem extends StatelessWidget {
  final Color color;
  final bool isCurrentColor;
  final void Function() changeColor;
  const _ThemeColorPickerItem({
    Key? key,
    required this.color,
    required this.isCurrentColor,
    required this.changeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 1.5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: changeColor,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(Icons.done, color: useWhiteForeground(color) ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

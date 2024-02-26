import 'package:flutter/material.dart';
import 'package:note_pad/views/utils/extensions/int_extensions.dart';
import 'package:note_pad/views/utils/extensions/text_style_extensions.dart';
import 'package:note_pad/views/utils/extensions/widget_extensions.dart';

import '../../utils/colors.dart';

class NotesWidgets {
  BuildContext context;

  NotesWidgets({required this.context});

  AppBar notesAbbBarView({ void Function()? onBackPressed,void Function()? onPressed, bool onlyRead = true}) =>
      AppBar(
        actions: [
          _itemCardView(IconButton(
              onPressed: onPressed,
              icon: Icon(
                onlyRead
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white,
              ))),
          10.width
        ],
        leading: _itemCardView(IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
            ))).paddingAll(2),
      );

  Widget _itemCardView(Widget child) => Card(
        elevation: 5,
        color: kPrimaryLightColor,
        child: child,
      );

  Widget textFieldView(TextEditingController controller,String hintText,
      {bool isTitle = false, bool enabled = true,void Function(String)? onChanged}) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      style: isTitle
          ? const TextStyle().whiteTitleTextStyle
          : const TextStyle(color: Colors.white),
      maxLines: null,
      cursorColor: Colors.white,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}

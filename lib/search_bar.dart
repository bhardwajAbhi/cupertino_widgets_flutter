import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:cupertino_widgets/styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  SearchBar({this.controller, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.searchBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.0,
          vertical: 8.0,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.search,
              color: Styles.searchIconColor,
            ),
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                focusNode: focusNode,
                style: Styles.searchText,
                cursorColor: Styles.searchCursorColor,
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: Icon(
                CupertinoIcons.clear_thick_circled,
                color: Styles.searchIconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

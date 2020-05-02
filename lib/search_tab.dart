import 'package:cupertino_widgets/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';
import 'product_row_list_item.dart';
import 'styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SearchBar(
        focusNode: _focusNode,
        controller: _controller,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final results = model.search(_terms);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ProductRowItem(
                  index: index,
                  product: results[index],
                  lastItem: index == results.length - 1,
                ),
                itemCount: results.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

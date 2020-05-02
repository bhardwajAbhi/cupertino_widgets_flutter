import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_widgets/model/app_state_model.dart';
import 'product_row_list_item.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final products = model.getProducts();
        return CustomScrollView(
          semanticChildCount: products.length,
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            ),
            SliverSafeArea(
              top: false,
              minimum: EdgeInsets.only(top: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < products.length) {
                    return ProductRowItem(
                      index: index,
                      product: products[index],
                      lastItem: index == products.length - 1,
                    );
                  }
                  return null;
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}

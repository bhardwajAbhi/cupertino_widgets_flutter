import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/product.dart';
import 'styles.dart';

class ProductRowItem extends StatelessWidget {
  final Product product;
  final int index;
  final bool lastItem;

  ProductRowItem({
    this.index,
    this.product,
    this.lastItem,
  });

  @override
  Widget build(BuildContext context) {
    final productRow = SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.cover,
              width: 76.0,
              height: 76.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: Styles.productRowItemName,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '\$${product.price}',
                      style: Styles.productRowItemPrice,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(
              CupertinoIcons.plus_circled,
            ),
            onPressed: () {
              final model = Provider.of<AppStateModel>(context);
              model.addProductToCart(product.id);
            },
          ),
        ],
      ),
    );

    final divider = Padding(
      padding: EdgeInsets.only(
        left: 100.0,
        right: 16.0,
      ),
      child: Container(
        height: 1.0,
        color: Styles.productRowDivider,
      ),
    );

    if (lastItem) {
      return productRow;
    }

    return Column(
      children: <Widget>[
        productRow,
        divider,
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_widgets/model/app_state_model.dart';
import 'package:cupertino_widgets/styles.dart';
import 'shopping_cart_item.dart';

import 'model/product.dart';

class ShoppingCardTab extends StatefulWidget {
  @override
  _ShoppingCardTabState createState() => _ShoppingCardTabState();
}

class _ShoppingCardTabState extends State<ShoppingCardTab> {
  String name;
  String email;
  String location;
  String pin;
  DateTime dateTime = DateTime.now();

  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  Widget _buildNameField() {
    return CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.person_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Name',
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget _buildEmailField() {
    return CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.mail_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Email',
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget _buildLocationField() {
    return CupertinoTextField(
      prefix: Icon(
        CupertinoIcons.location_solid,
        color: CupertinoColors.lightBackgroundGray,
        size: 28.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
      placeholder: 'Location',
      onChanged: (value) {
        setState(() {
          name = value;
        });
      },
    );
  }

  Widget _buildDateandTimePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  CupertinoIcons.clock,
                  color: CupertinoColors.lightBackgroundGray,
                  size: 28.0,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text('Delivery Time', style: Styles.deliveryTimeLabel),
              ],
            ),
            Text(
              DateFormat.yMMMd().add_jm().format(dateTime),
              style: Styles.deliveryTime,
            ),
          ],
        ),
        Container(
          height: 216.0,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: dateTime,
            onDateTimeChanged: (newDateTime) {
              setState(() {
                dateTime = newDateTime;
              });
            },
          ),
        ),
      ],
    );
  }

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
      AppStateModel model) {
    return SliverChildBuilderDelegate(
      (context, index) {
        final productIndex = index - 4;
        switch (index) {
          case 0:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildNameField(),
            );
          case 1:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildEmailField(),
            );
          case 2:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildLocationField(),
            );

          case 3:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _buildDateandTimePicker(context),
            );

          default:
            if (model.productsInCart.length > productIndex) {
              return ShoppingCartItem(
                index: index,
                product: model.getProductById(
                    model.productsInCart.keys.toList()[productIndex]),
                quantity: model.productsInCart.values.toList()[productIndex],
                lastItem: productIndex == model.productsInCart.length - 1,
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == productIndex &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Shipping ${_currencyFormat.format(model.shippingCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Tax ${_currencyFormat.format(model.tax)}',
                          style: Styles.productRowItemPrice,
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Total ${_currencyFormat.format(model.totalCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Shopping Cart'),
            ),
            SliverSafeArea(
              top: false,
              minimum: EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: _buildSliverChildBuilderDelegate(model),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/cart_provider.dart';
import 'package:shop_app/src/providers/products_provider.dart';
import 'package:shop_app/src/widgets/badge.dart';
import 'package:shop_app/src/widgets/drawer.dart';
import 'package:shop_app/src/widgets/products_builder.dart';

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  /* @override
  void initState() {
    Provider.of<ProductsProvider>(context,listen: false).fetchAllProducts(); 
    super.initState();
  } */
  bool _isLoading = true;
  bool _isFetching = false;
  @override
  void didChangeDependencies() {
    if (_isLoading) {
      setState(() {
        _isFetching = true;
      });
      Provider.of<ProductsProvider>(context).fetchAllProducts().then((_) {
        setState(() {
          _isFetching = false;
        });
      });
    }
    _isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (selectedValue) {
                if (selectedValue == 0) {
                  dataProvider.showFavoritesOnly();
                } else if (selectedValue == 1) {
                  dataProvider.showAll();
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: 1,
                  ),
                ];
              }),
          Consumer<CartProvider>(
            builder: (context, cartData, child) {
              return Badge(
                child: child,
                value: cartData.itemCount.toString(),
              );
            },
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                }),
          ),
        ],
      ),
      body: _isFetching
          ? Center(child: CircularProgressIndicator())
          : ProductsBuilder(),
    );
  }
}

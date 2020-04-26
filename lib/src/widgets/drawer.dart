import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Shopping'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/overview'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/orders'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('My Products'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/userProducts'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context,listen: false).logOut();
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:shopapp/screens/user_product_screen.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Hello!"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (){
              Navigator.pushReplacementNamed(context, ProductsOverViewScreen.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: (){
              Navigator.pushReplacementNamed(context, OrdersScreen.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: (){
              Navigator.pushReplacementNamed(context, UserProductScreen.url);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('logout'),
            onTap: (){
              Navigator.pop(context);
              Provider.of<Auth>(context,listen: false).logout();
            },
          ),
        ],
      ),
      elevation: 4,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/orders.dart' show Orders;
import 'package:shopapp/widgets/OrderItem.dart';
import 'package:shopapp/widgets/main_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const url = "/orders-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Orders"),
        ),
        drawer: MainDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).getOrdersData(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text("Error"),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length,
                  ),
                );
              }
            }
          },
        ));
  }
}

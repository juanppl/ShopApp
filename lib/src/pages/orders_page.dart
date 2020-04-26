import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/providers/orders_provider.dart';
import 'package:shop_app/src/widgets/drawer.dart';
import 'package:shop_app/src/widgets/order_item.dart';

class OrdersPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //final ordersProv = Provider.of<OrdersProvider>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context,listen: false).fetchAllProducts(),
        builder: (context, data){
          if(data.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Consumer<OrdersProvider>(
              builder: (context, ordersProv, child){
                return ListView.builder(
                  itemCount: ordersProv.orderItems.length,
                  itemBuilder: (context,index){
                    return OrderItem(orderModel: ordersProv.orderItems[index]);
                  }
                );
              },  
            );
          }
        }
      ),
      );
  }
}
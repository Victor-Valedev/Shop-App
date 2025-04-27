import 'package:flutter/material.dart';
import 'package:shopapp/models/order.dart';
import 'package:intl/intl.dart';

class OrderComponent extends StatefulWidget {
  final Order order;

  const OrderComponent({
    super.key,
    required this.order,
  });

  @override
  State<OrderComponent> createState() => _OrderComponentState();
}

class _OrderComponentState extends State<OrderComponent> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'R\$ ${widget.order.total.toStringAsFixed(2)}'
            ),
            subtitle: Text(
              DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date)
            ),
            trailing: IconButton(
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
              }, 
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)
            ),
          ),
          if(_expanded)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              height: (widget.order.products.length * 25.0) + 10,
              child: ListView(
                children: widget.order.products.map((prod) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        prod.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        '${prod.quantify}x R\$${prod.price}',
                        style: TextStyle(
                          fontSize:18,
                          color: Colors.grey 
                        ),
                      )
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key, required this.cart}) : super(key: key);

  final List cart;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    double total = widget.cart.fold(0, (sum, item) => sum + item.total);
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Shopping cart'.toUpperCase(), style: TextStyle(fontSize: 26)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cart.length,
            itemBuilder: (ctx, i) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 150,
                              child: FittedBox(
                                child: Image.network(widget.cart[i].image),
                                fit: BoxFit.fill,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 400,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.cart[i].itemdescription),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.cart[i].itemcode),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text('Quantity'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(widget.cart[i].quantity.toString()),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (widget.cart[i].quantity > 0) {
                                            setState(() {
                                              widget.cart[i].quantity =
                                                  widget.cart[i].quantity - 1;
                                              widget.cart[i].total =
                                                  widget.cart[i].quantity *
                                                      widget.cart[i].price;
                                            });
                                            if (widget.cart[i].quantity == 0) {
                                              widget.cart
                                                  .remove(widget.cart[i]);
                                            }
                                          }
                                        },
                                        icon: Icon(Icons.remove))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(widget.cart[i].price.toString()),
                                Divider(),
                                Text(
                                  'Total:' + (widget.cart[i].total).toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Visibility(
            visible: total > 0 ? true : false,
            child: Text(
              'Total: ' + total.toString(),
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

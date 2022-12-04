import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoppingcart/model/shoppingcart.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {Key? key,
      required this.listIndex,
      required this.products,
      required this.cart})
      : super(key: key);
  final List cart;
  final int listIndex;
  final List products;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

int itemcount = 0;

class _ProductDetailsState extends State<ProductDetails> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        itemcount = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product details', style: TextStyle(fontSize: 26)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Center(
                  child: Image.network(
                    widget.products[widget.listIndex].images.toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          widget.products[widget.listIndex].gallery.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          width: 100,
                          height: 100,
                          child: FittedBox(
                            child: Image.network(widget
                                .products[widget.listIndex]
                                .gallery[index]['url']
                                .toString()),
                            fit: BoxFit.fill,
                          ),
                        );
                      })),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.products[widget.listIndex].name,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.products[widget.listIndex].price,
                    style: TextStyle(fontSize: 24, color: Colors.black87),
                  )),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        itemcount != 0 ? itemcount-- : itemcount;
                      });
                    },
                    icon: Icon(Icons.remove),
                    iconSize: 30,
                  ),
                  Text(
                    itemcount.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        itemcount++;
                      });
                    },
                    icon: Icon(Icons.add),
                    iconSize: 30,
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (itemcount > 0) {
                            ShoppingCart cartItem = ShoppingCart(
                                itemcode: widget.products[widget.listIndex].code
                                    .toString(),
                                itemdescription: widget
                                    .products[widget.listIndex].name
                                    .toString(),
                                quantity: itemcount,
                                price: widget
                                    .products[widget.listIndex].pricevalue,
                                image: widget.products[widget.listIndex].images
                                    .toString(),
                                total: widget
                                        .products[widget.listIndex].pricevalue *
                                    itemcount);
                            widget.cart.add(cartItem);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Added to cart"),
                            ));
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Please choose quantity first',
                              backgroundColor: Colors.grey,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 20, letterSpacing: 1),
                        ),
                      )),
                ),
              )
            ],
          ),
        ));
  }
}

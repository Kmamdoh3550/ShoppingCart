import 'dart:ffi';
import 'dart:typed_data';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shoppingcart/cart.dart';
import 'package:shoppingcart/model/products.dart';
import 'package:shoppingcart/model/shoppingcart.dart';
import 'package:shoppingcart/productdetails.dart';
import 'package:shoppingcart/service/httpservice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

final numberFormat = new NumberFormat("###,###,###.00", "en_US");
List<ShoppingCart> cart = [];
double total = 0;
int cartlength = 0;

class _ProductsPageState extends State<ProductsPage> {
  int count = 0;
  HttpService service = HttpService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Products List'.toUpperCase(),
          style: TextStyle(fontSize: 26),
        )),
        actions: <Widget>[
          Badge(
            badgeContent: Text(
              cartlength.toString(),
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            position: BadgePosition.bottomEnd(bottom: 5, end: 15),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Cart(
                            cart: cart,
                          )),
                );
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: service.getProducts(),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 300,
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: FittedBox(
                                  child: Image.network(
                                    snapshot.data[index].images.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        snapshot.data[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data[index].price.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black45),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data[index].colortext.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black45),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      color: Color(int.parse(snapshot
                                          .data[index].color
                                          .toString()
                                          .replaceAll('#', '0xFF'))),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              height: 250,
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: IconButton(
                                            onPressed: () {
                                              var list = snapshot.data;
                                              List products = list;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetails(
                                                          listIndex: index,
                                                          products: products,
                                                          cart: cart,
                                                        )),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          )))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

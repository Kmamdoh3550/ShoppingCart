import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoppingcart/model/products.dart';

class HttpService {
  Future<List<Products>> getProducts() async {
    var headers = {
      'X-RapidAPI-Key': 'get your key from rapidapi.com ',
      'X-RapidAPI-Host': 'apidojo-hm-hennes-mauritz-v1.p.rapidapi.com'
    };
    var request = http.Request('GET', Uri.parse(''));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    List<Products> products = [];

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      final results = json.decode(body);

      for (var i = 0; i < results['results'].length; i++) {
        Products productItem = Products(
            code: results['results'][i]['code'].toString(),
            name: results['results'][i]['name'].toString(),
            price: results['results'][i]['price']['formattedValue'].toString(),
            images: results['results'][i]['images'][0]['url'].toString(),
            color: results['results'][i]['articles'][0]['rgbColor'].toString(),
            colortext: results['results'][i]['articles'][0]['color']['text']
                .toString(),
            quantity: 0,
            pricevalue: results['results'][i]['price']['value'],
            gallery: results['results'][i]['galleryImages']);

        products.add(productItem);
      }
    } else {}
    return products;
  }
}

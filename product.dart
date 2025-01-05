import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'if0_38041151_ice_cream_store.com';

class Product {
  final int _id;
  final String _name;
  final String _type;
  final double _pricePerKg;

  Product(this._id, this._name, this._type, this._pricePerKg);

  @override
  String toString() {
    return 'ID: $_id\nName: $_name\nType: $_type\nPrice: \$${_pricePerKg.toStringAsFixed(2)} / kg';
  }
}

List<Product> _products = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.http(_baseURL, 'getIceCreams.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
            int.parse(row['id']),
            row['name'],
            row['type'],
            double.parse(row['price_per_kg']));
        _products.add(p);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void searchProduct(Function(String text) update, String name) async {
  try {
    final url = Uri.http(_baseURL, 'searchIceCream.php', {'name': name});
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[0];
      Product p = Product(
          int.parse(row['id']),
          row['name'],
          row['type'],
          double.parse(row['price_per_kg']));
      _products.add(p);
      update(p.toString());
    }
  } catch (e) {
    update("Unable to load data");
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) => Column(children: [
          const SizedBox(height: 10),
          Container(
              color: index % 2 == 0 ? Colors.lightBlue : Colors.lightGreen,
              padding: const EdgeInsets.all(5),
              width: width * 0.9,
              child: Row(children: [
                SizedBox(width: width * 0.15),
                Flexible(
                    child: Text(_products[index].toString(),
                        style: TextStyle(fontSize: width * 0.045)))
              ]))
        ]));
  }
}

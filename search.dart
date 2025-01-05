import 'package:flutter/material.dart';
import 'product.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controllerName = TextEditingController();
  String _text = '';

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  void update(String text) {
    setState(() {
      _text = text;
    });
  }

  void getProduct() {
    try {
      String name = _controllerName.text;
      searchProduct(update, name);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid input')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Ice Cream'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
                width: 200,
                child: TextField(
                    controller: _controllerName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Ice Cream Name'))),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: getProduct,
                child: const Text('Find', style: TextStyle(fontSize: 18))),
            const SizedBox(height: 10),
            Center(
                child: SizedBox(
                    width: 200,
                    child: Flexible(
                        child: Text(_text,
                            style: const TextStyle(fontSize: 18))))),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'ShopPage.dart';

class CartPage extends StatefulWidget {
  final List<ProductInfo> productList;

  CartPage({required this.productList});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int> productQuantities = [];

  @override
  void initState() {
    super.initState();
    // Varsayılan ürün miktarlarını ayarla
    for (int i = 0; i < widget.productList.length; i++) {
      productQuantities.add(1);
    }
  }

  void _incrementQuantity(int index) {
    setState(() {
      productQuantities[index]++;
    });
  }

  void _decrementQuantity(int index) {
    if (productQuantities[index] > 1) {
      setState(() {
        productQuantities[index]--;
      });
    } else {
      _removeProduct(index);
    }
  }

  void _removeProduct(int index) {
    setState(() {
      widget.productList.removeAt(index);
      productQuantities.removeAt(index);
    });
  }

  void _addProduct(int index) {
    setState(() {
      productQuantities[index]++;
    });
  }

  void _buyProducts() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Satın Alma İşlemi'),
          content: Text('Ürünleri satın aldınız!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  widget.productList.clear();
                  productQuantities.clear();
                });
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (int i = 0; i < widget.productList.length; i++) {
      ProductInfo product = widget.productList[i];
      int quantity = productQuantities[i];
      totalPrice += product.price * quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sepet', style: TextStyle(color: Colors.pink)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          ProductInfo product = widget.productList[index];
          int quantity = productQuantities[index];
          return ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(product.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(product.title),
            subtitle: Text('${product.price.toStringAsFixed(2)} TL'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _decrementQuantity(index),
                  icon: Icon(Icons.remove),
                  color: Colors.pink,
                ),
                Text(quantity.toString()),
                IconButton(
                  onPressed: () => _incrementQuantity(index),
                  icon: Icon(Icons.add),
                  color: Colors.pink,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.pink,
            ),
            Text(
              'Toplam: ${totalPrice.toStringAsFixed(2)} TL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _buyProducts,
              child: Text('Satın Al'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

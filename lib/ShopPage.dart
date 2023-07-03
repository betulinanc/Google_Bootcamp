import 'package:flutter/material.dart';
import 'package:HomePage/CartPage.dart';
import 'AccountPage.dart';
import 'RentPage.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<ProductInfo> productList = [
    ProductInfo('images/shop_images/product1.jpg', 'Goody Köpek Maması', 99.99),
    ProductInfo('images/shop_images/product2.jpg', 'Perfect Köpek maması', 19.99),
    ProductInfo('images/shop_images/product3.jpg', 'Reflex Köpek Maması', 14.99),
    ProductInfo('images/shop_images/product4.jpg', 'Pro Plan', 7.99),
    ProductInfo('images/shop_images/product5.jpg', 'Ürün 5', 12.99),
    ProductInfo('images/shop_images/product6.jpg', 'Ürün 6', 9.99),
    ProductInfo('images/shop_images/product7.jpg', 'Hills Köpek Maması', 6.99),
    ProductInfo('images/shop_images/product8.jpg', 'Ürün 8', 16.99),
    ProductInfo('images/shop_images/product9.jpg', 'Ürün 9', 11.99),
    ProductInfo('images/shop_images/product10.jpg', 'Ürün 10', 8.99),
    ProductInfo('images/shop_images/product11.jpg', 'Ürün 11', 13.99),
    ProductInfo('images/shop_images/product12.jpg', 'Ürün 12', 15.99),
  ];

  List<ProductInfo> cartItems = [];
  TextEditingController searchController = TextEditingController();
  List<ProductInfo> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = productList;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.pink,
            ),
            SizedBox(width: 8),
            Text(
              'Market',
              style: TextStyle(color: Colors.pink),
            ),
            Icon(
              Icons.shopping_cart,
              color: Colors.pink,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(productList: cartItems)),
              );
            },
            icon: Icon(
              Icons.shopping_bag,
              color: Colors.pink,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredList = productList
                      .where((product) => product.title.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Ürün Ara',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: _buildProductRows(context),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomButton(
                context,
                'Ana Sayfa',
                Icons.home,
                Colors.pink,
                    () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                icon: Icon(Icons.local_hospital),
                label: Text('Bakıcı Kirala', style: TextStyle(fontSize: 16)),
              ),
              _buildBottomButton(
                context,
                'Hesap',
                Icons.person,
                Colors.pink,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AccountPage()),

                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProductRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < filteredList.length; i += 3) {
      if (i + 3 <= filteredList.length) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductCard(context, filteredList[i]),
              _buildProductCard(context, filteredList[i + 1]),
              _buildProductCard(context, filteredList[i + 2]),
            ],
          ),
        );
      } else {
        List<Widget> rowChildren = [];
        for (int j = i; j < filteredList.length; j++) {
          rowChildren.add(_buildProductCard(context, filteredList[j]));
        }
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rowChildren,
          ),
        );
      }
      rows.add(SizedBox(height: 16));
    }
    return rows;
  }


  Widget _buildProductCard(BuildContext context, ProductInfo productInfo) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Ürüne tıklama işlemleri
                print('Ürüne tıklandı: ${productInfo.title}');
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(productInfo.imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              productInfo.title,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _addToCart(productInfo); // Ürünü sepete ekle
              },
              child: Text('Sepete Ekle - ${productInfo.price.toStringAsFixed(2)} TL'),
            ),
          ],
        ),
      ),
    );
  }


  void _addToCart(ProductInfo productInfo) {
    setState(() {
      cartItems.add(productInfo); // Ürünü sepete ekle
    });
  }

  Widget _buildBottomButton(
      BuildContext context,
      String label,
      IconData icon,
      Color color,
      VoidCallback onPressed,
      ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class ProductInfo {
  final String imagePath;
  final String title;
  final double price;

  ProductInfo(this.imagePath, this.title, this.price);
}

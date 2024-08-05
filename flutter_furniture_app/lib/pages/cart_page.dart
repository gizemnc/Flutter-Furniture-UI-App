import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/model.dart';
import 'package:flutter_furniture_app/services/app_api.dart';
import 'package:flutter_furniture_app/services/cart_provider.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:flutter_furniture_app/constants/constants.dart'; // Import Constants

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<AppModel> futureAppModel;

  @override
  void initState() {
    super.initState();
    futureAppModel = ApiService().loadData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Constants.settingsAndCartTitleStyle),
        backgroundColor: Colors.purple[300],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.cartItems;
          final totalPrice = cartProvider.totalPrice;
          final totalOriginalPrice = cartProvider.totalOriginalPrice;
          final totalSavings = cartProvider.totalSavings;

          return cartItems.isEmpty
              ? Center(child: Text('No items in the cart', style: Constants.settingsAndCartTextStyle))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            return Dismissible(
                              key: Key(product.title ?? 'Product'), // Unique key for each item
                              direction: DismissDirection.endToStart, // Swipe direction to the left
                              onDismissed: (direction) {
                                cartProvider.removeFromCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${product.title} removed from cart', style: Constants.settingsAndCartTextStyle),
                                  ),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Card(
                                elevation: 4,
                                child: ListTile(
                                  leading: Image.network(
                                    product.thumbnails.isNotEmpty
                                        ? product.thumbnails[0][4]
                                        : '', // Ensure the image URL is not empty
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(product.title ?? 'Product', style: Constants.settingsAndCartTextStyle),
                                  subtitle: product.priceWas > 0
                                      ? Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '\$${product.priceWas.toStringAsFixed(2)}\n',
                                                style: Constants.settingsAndCartTextStyle.copyWith(
                                                  color: Colors.red,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '\$${product.price.toStringAsFixed(2)}',
                                                style: Constants.settingsAndCartTextStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: Constants.settingsAndCartTextStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Original Price: \$${totalOriginalPrice.toStringAsFixed(2)}',
                        style: Constants.settingsAndCartTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                        style: Constants.settingsAndCartTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Savings: \$${totalSavings.toStringAsFixed(2)}',
                        style: Constants.settingsAndCartTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

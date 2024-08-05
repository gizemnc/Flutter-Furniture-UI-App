import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_furniture_app/constants/constants.dart';
import 'package:flutter_furniture_app/model/model.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/pages/cart_page.dart';
import 'package:flutter_furniture_app/services/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final UserModel user;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.user,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product images carousel slider
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                  ),
                  items: widget.product.thumbnails.map((thumbnail) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              thumbnail[4],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.thumbnails.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the tapped image in the carousel
                        CarouselSlider(
                          items: widget.product.thumbnails.map((thumbnail) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      thumbnail[4],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                          options: CarouselOptions(
                            height: 300,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        );
                      },
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_currentImageIndex == entry.key ? 0.9 : 0.4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product title
                      Text(
                        widget.product.title ?? '',
                        style: Constants.loginHeadTitle,
                      ),
                      const SizedBox(height: 8),
                      // Product rating and reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700]),
                          const SizedBox(width: 4),
                          Text(
                            // ignore: unnecessary_null_comparison
                            '${widget.product.rating != null ? widget.product.rating.toStringAsFixed(1) : 'No Rating Available'} (${widget.product.reviews} reviews)',
                            style: Constants.loginTitle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Product price
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: Constants.productPriceStyle,
                      ),
                      if (widget.product.priceWas > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          '\$${widget.product.priceWas.toStringAsFixed(2)}',
                          style: Constants.oldPriceStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Save \$${widget.product.priceSaving.toStringAsFixed(2)} (${widget.product.percentageOff}% off)',
                          style: Constants.savingsStyle,
                        ),
                      ],
                      const SizedBox(height: 16),
                    
                      Text(
                        'Model Number: ${widget.product.modelNumber}',
                        style: Constants.subTitleDetailsTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Brand: ${widget.product.brand}',
                        style: Constants.subTitleDetailsTextStyle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Unit: ${widget.product.unit}',
                        style: Constants.subTitleDetailsTextStyle,
                      ),
                      const SizedBox(height: 16),
                      // Buy button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showConfirmationDialog(context);
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: Text('Buy', style: Constants.loginPageButtonTitle),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                            textStyle: Constants.loginPageButtonTitle,
                            backgroundColor: Colors.purple[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Purchase'),
          content: const Text('Are you sure you want to add this item to the cart?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Add the product to the cart
                Provider.of<CartProvider>(context, listen: false).addToCart(widget.product);
                // Navigate to the CartPage
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}

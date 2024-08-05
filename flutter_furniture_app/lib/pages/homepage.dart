import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/model.dart';
import 'package:flutter_furniture_app/model/user_model.dart';
import 'package:flutter_furniture_app/pages/detail_page.dart';
import 'package:flutter_furniture_app/pages/settings_page.dart';
import 'package:flutter_furniture_app/pages/cart_page.dart';
import 'package:flutter_furniture_app/services/app_api.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  const HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<AppModel> futureAppModel;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureAppModel = ApiService().loadData(); // Fetch data when the widget is initialized
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      return; // Prevent navigation if the same tab is selected
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => HomePage(user: widget.user)),
        );
        break;
      case 1:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (context) => const CartPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      
      body: Column(
        children: [
          
          Expanded(
            child: FutureBuilder<AppModel>(
              future: futureAppModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading data: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No data found.'));
                } else {
                  final appModel = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.75, // Adjust aspect ratio for better design
                    ),
                    itemCount: appModel.products.length,
                    itemBuilder: (context, index) {
                      final product = appModel.products[index];
                      final imageUrl = product.thumbnails[0][4];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }


}

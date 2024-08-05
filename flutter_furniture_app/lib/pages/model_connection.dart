import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/model.dart';
import 'package:flutter_furniture_app/pages/deneme.dart';
import 'package:flutter_furniture_app/services/app_api.dart';

class ModelConnection extends StatefulWidget {
  const ModelConnection({super.key});

  @override
  State<ModelConnection> createState() => _ModelConnectionState();
}

class _ModelConnectionState extends State<ModelConnection> {
  late Future<AppModel> futureAppModel;

 @override
  void initState() {
    super.initState();
    futureAppModel = ApiService().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DenemePage()));
        }, child:const Icon(Icons.arrow_forward))],
        title: const Text("Furniture App"),
          ),
      body: FutureBuilder<AppModel>(
        future: futureAppModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Veri yüklenirken hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Veri bulunamadı.'));
          } else {
            final appModel = snapshot.data!;
            return ListView.builder(
              itemCount: appModel.products.length,
              itemBuilder: (context, index) {
                final product = appModel.products[index];
                return Card(
                  elevation: 4,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.purple.shade50,
                  child: ListTile(
                    title: Text("${product.price}     id = ${appModel.searchMetadata!.id}"),
                    subtitle: Text('Fiyat: ${product.price} - Marka: ${product.brand}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
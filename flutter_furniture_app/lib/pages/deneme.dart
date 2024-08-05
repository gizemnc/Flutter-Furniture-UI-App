import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/model/model.dart';
import 'package:flutter_furniture_app/services/app_api.dart';

class DenemePage extends StatefulWidget {
  const DenemePage({super.key});

  @override
  State<DenemePage> createState() => _DenemePageState();
}

class _DenemePageState extends State<DenemePage> {



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
        title: const Text("Deneme"),
      ),
      body: FutureBuilder(
        future: futureAppModel,
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Veri yüklenirken hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Veri bulunamadı.'));
          }else{
          final appModel = snapshot.data!;
          var src = appModel.products[0].thumbnails[0][4];
          return Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: Image.network(src),
            ),
          );
  }},)
    );
  }
}
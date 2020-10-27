import 'package:flutter/material.dart';
import 'package:smartmei_app/services/breeds.dart';

class BreedsDetailScreen extends StatelessWidget {
  final breedsService = BreedsService();
  final String breed;

  BreedsDetailScreen(this.breed);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed),
      ),
      body: FutureBuilder(
        initialData: [],
        future: breedsService.findImagesByBreed(breed),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          List<String> images = snapshot.data;
          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Image.network(images[index]);
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartmei_app/screens/breeds_detail.dart';
import 'package:smartmei_app/services/breeds.dart';
import 'package:smartmei_app/extensions/string.dart';

class BreedsList extends StatelessWidget {
  final breedsService = BreedsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SmartMEI Dogs'),
      ),
      body: FutureBuilder<List<String>>(
        initialData: [],
        future: breedsService.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          List<String> breeds = snapshot.data;
          return ListView.builder(
            itemCount: breeds.length,
            itemBuilder: (context, index) {
              var breed = breeds[index].capitalize();
              return ListTile(
                title: Text(breed),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BreedsDetailScreen(breed);
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}

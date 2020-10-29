import 'package:flutter/material.dart';
import 'package:smartmei_app/screens/breeds_detail.dart';
import 'package:smartmei_app/services/breeds.dart';
import 'package:smartmei_app/extensions/string.dart';

class BreedsList extends StatefulWidget {
  @override
  _BreedsListState createState() => _BreedsListState();
}

class _BreedsListState extends State<BreedsList> {
  final breedsService = BreedsService();

  ScrollController scrollController;

  int limit = 20;
  bool loading = false;
  bool done = false;

  @override
  void initState() {
    scrollController = new ScrollController()
      ..addListener(() {
        if (scrollController.position.extentAfter < 500) {
          more();
        }
      });
    super.initState();
  }

  void more() {
    if (!loading) {
      setState(() {
        limit += 10;
        loading = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          loading = false;
        });
      });
    }
  }

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
          if (snapshot.connectionState != ConnectionState.done && !done) {
            return Center(child: CircularProgressIndicator());
          }

          if (!done) {
            Future.delayed(
              Duration(milliseconds: 100),
              () => setState(() {
                done = true;
              }),
            );
          }

          List<String> breeds = snapshot.data;
          if (breeds.length > limit) {
            breeds = breeds.sublist(0, limit);
          }

          return ListView.builder(
            controller: scrollController,
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

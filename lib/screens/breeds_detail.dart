import 'package:flutter/material.dart';
import 'package:smartmei_app/services/breeds.dart';

class BreedsDetailScreen extends StatefulWidget {
  final String breed;

  BreedsDetailScreen(this.breed);

  @override
  _BreedsDetailScreenState createState() => _BreedsDetailScreenState();
}

class _BreedsDetailScreenState extends State<BreedsDetailScreen> {
  final breedsService = BreedsService();

  ScrollController scrollController;

  int offset = 10;
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
        offset += 10;
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
        title: Text('${widget.breed} | $offset'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: breedsService.findImagesByBreed(widget.breed),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done && !done) {
            return Center(child: CircularProgressIndicator());
          }

          Future.delayed(
            Duration(milliseconds: 100),
            () => setState(() {
              done = true;
            }),
          );

          List<String> images = snapshot.data;

          if (images.length > offset) {
            images = images.sublist(0, offset);
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  width: double.maxFinite,
                  child: FadeInImage.assetNetwork(
                    image: images[index],
                    fit: BoxFit.fill,
                    placeholder: 'images/footprint.png',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

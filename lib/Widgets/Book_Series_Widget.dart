import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prearticle/Screens/Contents_List.dart';

class BookSeriesWidget extends StatefulWidget {
  BookSeriesWidget({Key key}) : super(key: key);

  @override
  _BookSeriesWidgetState createState() => _BookSeriesWidgetState();
}

class _BookSeriesWidgetState extends State<BookSeriesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => Contents(
                    onPressed: () {},
                  ),
                ),
              );
            },
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://cdn.shopify.com/s/files/1/0057/3728/3618/products/5cae019e64c0ee10ead36a00e60f0137_eeb2d749-fdbe-46fd-978a-870cc7e0ddf7_500x.jpg?v=1573593942',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

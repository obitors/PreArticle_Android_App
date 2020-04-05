import 'dart:ui';
import 'package:flutter/material.dart';

class Movie {
  final String url;
  final String title;

  const Movie({this.url, this.title});
}

const movies = [
  const Movie(
      url: 'https://i.ytimg.com/vi/YcHKrNMwWyQ/movieposter.jpg', title: 'Dorazvuuvvvvv'),
  const Movie(
      url:
          'https://cdn.shopify.com/s/files/1/0057/3728/3618/products/5cae019e64c0ee10ead36a00e60f0137_eeb2d749-fdbe-46fd-978a-870cc7e0ddf7_500x.jpg?v=1573593942',
      title: 'Jokernjinininibn'),
  const Movie(
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRAog3B6UEzMDOhehRXmjQbV2qYGOHYMh3jGGwqL7zwnwRJ6YyD',
      title: 'Predatorvghvgubvgu'),
  const Movie(
    url:
        'https://images-na.ssl-images-amazon.com/images/I/719fSnntGgL._AC_SL1500_.jpg',
    title: 'Anabellebhbjhbjhb',
  ),
];

class MoviesConceptPage extends StatefulWidget {
  @override
  _MoviesConceptPageState createState() => _MoviesConceptPageState();
}

class _MoviesConceptPageState extends State<MoviesConceptPage> {


  final pageController = PageController(viewportFraction: .8);
  final ValueNotifier<double> _pageNotifier = ValueNotifier(0.0);

  void _listener() {
    _pageNotifier.value = pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              itemCount: movies.length,
              controller: pageController,
              itemBuilder: (context, index) {
                final lerp =
                    lerpDouble(0, 0, (index - _pageNotifier.value).abs());
                double opacity =
                    lerpDouble(0.0, .3, (index - _pageNotifier.value).abs());
                double heights =
                    lerpDouble(size.height / 2, size.height / 2.2, (index - _pageNotifier.value).abs());
                if (opacity > 1.0) opacity = 1.0;
                if (opacity < 0.0) opacity = 0.0;
                return Transform.translate(
                  offset: Offset(0.0, lerp * 50),
                  child: Opacity(
                    opacity: (1 - opacity),
                    child: Align(
                      alignment: Alignment.center,
                      child: Card(
                        color: Colors.transparent,
                        borderOnForeground: true,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          height: heights,
                          width: size.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 20.0, right: 20.0, bottom: 20),
                                  child: ClipRRect(
                                    borderRadius: borderRadius,
                                    child: Image.network(
                                      movies[index].url,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              /*Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    movies[index].title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
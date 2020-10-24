import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';
import 'package:porfolio_movies_app/src/providers/movies_Provider.dart';
import 'package:porfolio_movies_app/src/widgets/card_swiper_widget.dart';
import 'package:porfolio_movies_app/src/widgets/horizontal_card_array.dart';

class HomePage extends StatelessWidget {
  static String id = '/';
  final MoviesProvider moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Movies on cine'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              _cardSwiper(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: moviesProvider.getPlayingNow(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwipper(
            movies: snapshot.data,
          );
        } else
          return Container(
              height: 200.0, child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
//      color: Colors.red[200],
      height: 300,
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text('Populars', style: Theme.of(context).textTheme.subtitle1),
        ),
        SizedBox(height: 4.0),
        StreamBuilder(
          stream: moviesProvider.popularStream,
          builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              return HorizontalCardArray(
                  movies: snapshot.data, nextPage: moviesProvider.getPopular);
            } else
              return Container(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator()));
          },
        )
      ]),
    );
  }
}

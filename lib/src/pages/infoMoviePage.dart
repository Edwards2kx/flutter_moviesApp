import 'dart:js';

import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';
import 'package:porfolio_movies_app/src/pages/actorPage.dart';
import 'package:porfolio_movies_app/src/providers/actors_Provider.dart';
import 'package:porfolio_movies_app/src/providers/movies_Provider.dart';

class InfoMovie extends StatelessWidget {
  static String id = 'infoMovie';

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(slivers: [
        _sliverAppbar(movie),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 10.0),
          _heroTitle(context, movie),
          _description(context, movie),
          _description(context, movie),
          _description(context, movie),
          _description(context, movie),
          _castingList(movie.id),
        ]))
      ]),
    );
  }

  Widget _sliverAppbar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      centerTitle: true,
      floating: false,
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.originalTitle),
        centerTitle: true,
        background: FadeInImage(
          fadeInDuration: Duration(milliseconds: 150),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getBackgroundImage()),
        ),
      ),
    );
  }

  Widget _heroTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                movie.getPosterImage(),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headline6,
                overflow: TextOverflow.ellipsis,
              ),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  )
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Text(
        movie.overview,
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _castingList(int movieId) {
    ActorsProvider actorsProvider = ActorsProvider();
    //MoviesProvider moviesProvider = MoviesProvider();

    return Container(
      child: FutureBuilder(
        future: actorsProvider.getCast(movieId),
        builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
          if (snapshot.hasData) {
            return _actorCardBuilder(snapshot.data);
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget _actorCardBuilder(List<Actor> actors) {
    return Container(
      height: 200.0,
      child: PageView.builder(
        itemCount: actors.length,
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        itemBuilder: (context, i) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  print('${actors[i].name} , ${actors[i].character} , ${actors[i].id}');
                  Navigator.pushNamed(context, ActorPage.id , arguments: actors[i]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    height: 150.0,
                    placeholder: AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover,
                    image: NetworkImage(actors[i].getProfileImage()),
                  ),
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(
                actors[i].name,
                overflow: TextOverflow.ellipsis,
              )
            ],
          );
        },
      ),
    );
  }
}

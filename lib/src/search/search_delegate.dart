import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';
import 'package:porfolio_movies_app/src/pages/infoMoviePage.dart';
import 'package:porfolio_movies_app/src/providers/movies_Provider.dart';

class DataSearch extends SearchDelegate {
  final peliculas = [
    'Spideman',
    'Hulk',
    'Ironman',
    'Sonic',
    'Aquaman',
    'Superman 1',
    'Superman 2',
    'Superman 3',
    'Superman 4',
  ];

  final sugeridas = ['Hulk', 'Mortal Kombat'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final MoviesProvider moviesProvider = MoviesProvider();
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapShot) {
        if (snapShot.hasData) {
          final movies = snapShot.data;
          return ListView(
            children: movies.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.getPosterImage()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context , null);
                  //movie.uniqueId = '';
                  Navigator.pushNamed(context, InfoMovie.id , arguments: movie);
                  //print(movie.id);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

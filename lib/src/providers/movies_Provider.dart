import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';

class MoviesProvider {

  String _apiKey = '96289fed672d682730bc8b06d8091423';
  String _url = 'api.themoviedb.org';
  //String _url = 'https://api.themoviedb.org/3/movie/';
  String _language = 'en-US';

  int _playingNowPage = 0;
  int _popularPage = 0;
  bool _loadingMoviesPopular = false;

  List<Movie> _popular = new List();
  List<Movie> _playingNow = new List();

  final _popularStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposePopularStream() {
    _popularStreamController?.close();
  }


  Future<List<Movie>> getPlayingNow() async {

    _playingNowPage++;

    String _endPoint = '3/movie/now_playing';
    final url = Uri.https(_url, _endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page' : _playingNowPage.toString(),
    });

    return await _requestToApi(url);

  }

  Future<List<Movie>> getPopular() async {

    if (_loadingMoviesPopular == true) return [];

    _loadingMoviesPopular = true;
    _popularPage++;

    String _endPoint = '3/movie/popular';
    final url = Uri.https(_url, _endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'page' : _popularPage.toString(),
    });


    final _movieList = await _requestToApi(url);

    _popular.addAll(_movieList);
    popularSink(_popular);

    _loadingMoviesPopular = false;

    return _movieList;
    
  }

Future<List<Movie>> searchMovie(String _query) async {

//    _playingNowPage++;

    String _endPoint = '3/search/movie';
    final url = Uri.https(_url, _endPoint, {
      'api_key': _apiKey,
      'language': _language,
      'query': _query
    });

    return await _requestToApi(url);

  }



  Future<List<Movie>> _requestToApi(Uri url) async {
    final _response = await http.get(url);
    if (_response.statusCode == 200) {
      final _data = json.decode(_response.body);
      final _movies = Movies.fromJson(_data['results']);
      return _movies.items;
    } else {
      print('error in request of: $url');
      return [];
    }
  }


}

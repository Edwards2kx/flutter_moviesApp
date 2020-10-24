import 'dart:convert';
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ActorsProvider {

   String _apiKey = '96289fed672d682730bc8b06d8091423';
  String _url = 'api.themoviedb.org';
  //String _url = 'https://api.themoviedb.org/3/movie/';
  String _language = 'en-US';

   Future<List<Actor>> getCast( int id) async {
    String _endPoint = '3/movie/$id/credits';
    final url = Uri.https(_url, _endPoint, {
      'api_key': _apiKey,
    });

    final _response = await http.get(url);
    if (_response.statusCode == 200) {
      final _data = json.decode(_response.body);
      final _casting = Cast.fromJsonList(_data['cast']);
      return _casting.actors;
    } else {
      print('error in request of: $url');
      return [];
    }
  }

  Future<Actor> getActor( int personId) async {
    String _endPoint = '3/person/$personId';
    final url = Uri.https(_url, _endPoint, {
      'api_key': _apiKey,
    });

    final _response = await http.get(url);
    if (_response.statusCode == 200) {
      final _data = json.decode(_response.body);
      final _actor = Actor.detailedFromJson(_data);
      return _actor;
    } else {
      print('error in request of: $url');
      return Actor();
    }
  }



}
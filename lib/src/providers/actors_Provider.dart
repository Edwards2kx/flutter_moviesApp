import 'dart:convert';
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ActorsProvider {
  String _apiKey = '96289fed672d682730bc8b06d8091423';
  String _url = 'api.themoviedb.org';
  //String _url = 'https://api.themoviedb.org/3/movie/';
  
  //String _language = 'en-US';

  static Actor dummyActor = Actor(
    adult: false,
    alsoKnownAs: [
      "Джим Керри",
      "占·基利",
      "จิม แคร์รีย์",
      "ジム・キャリー",
      "جيم كاري",
      "짐 캐리",
      "Τζιμ Κάρεϊ"
    ],
    biography: "James Eugene \"Jim\" Carrey is a Canadian-American actor, comedian, singer and writer. He has received two Golden Globe Awards and has also been nominated on four occasions.\n\nCarrey began stand-up comedy in 1979, performing at Yuk Yuk's in Toronto, Ontario. After gaining prominence in 1981, he began working at The Comedy Store in Los Angeles where he was soon noticed by comedian Rodney Dangerfield, who immediately signed him to open his tour performances.\n\nCarrey, long interested in film and television, developed a close friendship with comedian Damon Wayans, which landed him a role in the sketch comedy hit In Living Color, in which he portrayed various characters during the show's 1990 season. Having had little success in television movies and several low-budget films, Carrey was cast as the title character in Ace Ventura: Pet Detective which premiered in February, 1994, making more than \$72 million domestically. The film spawned a sequel, Ace Ventura: When Nature Calls (1995), in which he reprised the role of Ventura.\n\nHigh profile roles followed when he was cast as Stanley Ipkiss in The Mask (1994) for which he gained a Golden Globe Award nomination for Best Actor in a Musical or Comedy, and as Lloyd Christmas in the comedy film Dumb and Dumber (1994). Between 1996 and 1999, Carrey continued his success after earning lead roles in several highly popular films including The Cable Guy (1996), Liar Liar (1997), in which he was nominated for another Golden Globe Award and in the critically acclaimed films The Truman Show and Man on the Moon, in 1998 and 1999, respectively. Both films earned Carrey Golden Globe awards. Since earning both awards — the only two in his three-decade career— Carrey continued to star in comedy films, including How the Grinch Stole Christmas (2000) where he played the title character, Bruce Almighty (2003) where he portrayed the role of unlucky TV reporter Bruce Nolan, Lemony Snicket's A Series of Unfortunate Events (2004), Fun with Dick and Jane (2005), Yes Man (2008), and A Christmas Carol (2009).\n\nCarrey has also taken on more serious roles including Joel Barish in Eternal Sunshine of the Spotless Mind (2004) alongside Kate Winslet and Kirsten Dunst, which earned him another Golden Globe nomination, and Steven Jay Russell in I Love You Phillip Morris (2009) alongside Ewan McGregor.   Description above from the Wikipedia article Jim Carrey, licensed under CC-BY-SA, full list of contributors on Wikipedia.",
    birthday: "1962-01-17",
    deathday: "2010-07-22",
    //deathday: null,
    gender: 2,
    homepage: "http://www.jimcarrey.com",
    id: 206,
    imdbId: "nm0000120",
    knownForDepartment: "Acting",
    name: "Jim Carrey",
    placeOfBirth: "Newmarket, Ontario, Canada",
    popularity: 10.622,
    profilePath: "/ienbErTKd9RHCV1j7FJLNEWUAzn.jpg"
  );

  Future<List<Actor>> getCast(int id) async {
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

  Future<Actor> getActor(int personId) async {
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

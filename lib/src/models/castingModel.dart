class Cast {
  List<Actor> actors = [];

  Cast(this.actors);

  Cast.fromJsonList(List<dynamic> _actors) {
    if (_actors == null) return;

    _actors.forEach((element) {
      Actor actor = Actor.fromJson(element);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;
  //detailed properties
  String birthday = '';
  String knownForDepartment;
  dynamic deathday = '';
  List<String> alsoKnownAs;
  String biography;
  double popularity;
  String placeOfBirth = '';
  bool adult;
  String imdbId;
  dynamic homepage;

  Actor(
      {this.castId,
      this.character,
      this.creditId,
      this.gender,
      this.id,
      this.name,
      this.order,
      this.profilePath,
      this.birthday,
      this.knownForDepartment,
      this.deathday,
      this.alsoKnownAs,
      this.biography,
      this.popularity,
      this.placeOfBirth,
      this.adult,
      this.imdbId,
      this.homepage

      });

      

  Actor.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  Actor.detailedFromJson(json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    birthday = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday = json['deathday'];
    //alsoKnownAs = json['also_known_as'].cast<String>();
    biography = json['biography'];
    popularity = json['popularity'];
    placeOfBirth = json['place_of_birth'];
    profilePath = json['profile_path'];
    adult = json['adult'];
    imdbId = json['imdb_id'];
    homepage = json['homepage'];
  }

  String getProfileImage() {
    if (profilePath == null) {
      return 'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1214428300?b=1&k=6&m=1214428300&s=612x612&w=0&h=kMXMpWVL6mkLu0TN-9MJcEUx1oSWgUq8-Ny6Wszv_ms=';
    } else {
      final String _imagePath = 'https://image.tmdb.org/t/p/w500/';
      return (_imagePath + profilePath);
    }
  }
}



class Movies {
  List<Movie> items = [];

  Movies(this.items);

  Movies.fromJson(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      items.add(Movie.fromJson(item));
    }
  }
}

class Movie {
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;
  String uniqueId;

  Movie(
      {this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.video,
      this.voteAverage});

  Movie.fromJson(Map<String, dynamic> json) {
    try {
      posterPath = json['poster_path'];
      adult = json['adult'];
      overview = json['overview'];
      releaseDate = json['release_date'];
      genreIds = json['genre_ids'].cast<int>();
      id = json['id'];
      originalTitle = json['original_title'];
      originalLanguage = json['original_language'];
      title = json['title'];
      backdropPath = json['backdrop_path'];
      popularity = json['popularity'];
      voteCount = json['vote_count'];
      video = json['video'];
      voteAverage = json['vote_average'] / 1;
    } catch (e) {
      print('error while parsing data on movie.fromJson');
    }
  }

  String getPosterImage() {
    if (posterPath == null) {
      return 'https://www.agora-gallery.com/advice/wp-content/uploads/2015/10/image-placeholder.png';
    } else {
      final String _imagePath = 'https://image.tmdb.org/t/p/w500/';
      return (_imagePath + posterPath);
    }
  }


String getBackgroundImage() {
    if (posterPath == null) {
      return 'https://www.agora-gallery.com/advice/wp-content/uploads/2015/10/image-placeholder.png';
    } else {
      final String _imagePath = 'https://image.tmdb.org/t/p/w500/';
      return (_imagePath + backdropPath);
    }
  }
  

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['poster_path'] = this.posterPath;
  //   data['adult'] = this.adult;
  //   data['overview'] = this.overview;
  //   data['release_date'] = this.releaseDate;
  //   data['genre_ids'] = this.genreIds;
  //   data['id'] = this.id;
  //   data['original_title'] = this.originalTitle;
  //   data['original_language'] = this.originalLanguage;
  //   data['title'] = this.title;
  //   data['backdrop_path'] = this.backdropPath;
  //   data['popularity'] = this.popularity;
  //   data['vote_count'] = this.voteCount;
  //   data['video'] = this.video;
  //   data['vote_average'] = this.voteAverage;
  //   return data;
  // }
}

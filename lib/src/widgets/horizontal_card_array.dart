import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';
import 'package:porfolio_movies_app/src/pages/infoMoviePage.dart';

class HorizontalCardArray extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;
  final PageController _pageController =
      new PageController(viewportFraction: 0.3, initialPage: 1);

  HorizontalCardArray({@required this.movies, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: screenSize.height * 0.3,
      child: PageView.builder(
          controller: _pageController,
          pageSnapping: false,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return movieCard(movies[index], context);
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {

              movie.uniqueId = '${movie.id} - subSection';
    return GestureDetector(
      onTap: () {
        //print('pinchaste sobre ${movie.originalTitle}');
        Navigator.pushNamed(context, InfoMovie.id, arguments: movie);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => InfoMovie(movie)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                    movie.getPosterImage(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              movie.originalTitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}

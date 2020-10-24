import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:porfolio_movies_app/src/models/moviesModel.dart';
import 'package:porfolio_movies_app/src/pages/infoMoviePage.dart';

class CardSwipper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwipper({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.5,
      child: Swiper(
        itemWidth: screenSize.width * 0.6,
        itemHeight: screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        //pagination: SwiperPagination(),
//        control: SwiperControl(color: Colors.red),
        itemCount: movies.length,
        itemBuilder: (context, index) {
              movies[index].uniqueId = '${movies[index].id} - mainSection';
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InfoMovie.id,
                  arguments: movies[index]);
            },
            child: Hero(
              tag: movies[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  image: NetworkImage(
                    movies[index].getPosterImage(),
                  ),
                ),
              ),
            ),
          );
//          child: Image.network(movies[index].posterPath , fit: BoxFit.cover, alignment: Alignment.topCenter,),);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:porfolio_movies_app/src/providers/actors_Provider.dart';

class ActorPage extends StatelessWidget {
  static String id = 'actorPage';

  @override
  Widget build(BuildContext context) {
    ActorsProvider actorsProvider = ActorsProvider();
    final Actor actor = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: actorsProvider.getActor(actor.id),
          builder: (BuildContext context, AsyncSnapshot<Actor> snapshot) {
            if (snapshot.hasData) {
              final Actor _actor = snapshot.data;
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _heroActor(context, _actor),
                        _actorBio(context, _actor.biography),
                        //CarouselSlider
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
//         body: CustomScrollView(
//       slivers: [
//         SliverList(
//           delegate: SliverChildListDelegate([
//             _heroActor(context, actor.id, actorsProvider),
// //            _heroBio(context)
//           ]),
//         )
//       ],
//     ));
//   }

  Widget _heroActor(BuildContext context, Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      height: 250.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(actor.getProfileImage(),
                height: 200.0, fit: BoxFit.contain),
          ),
          SizedBox(
            width: 10.0,
          ),
          actorInfo(actor, context),
        ],
      ),
    );
  }

  Column actorInfo(Actor _actor, BuildContext context) {
    final TextStyle _infoText = Theme.of(context).textTheme.subtitle1;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(_actor.name, style: Theme.of(context).textTheme.headline5),
      Text(_actor.gender == 1 ? 'Gender: Female' : 'Gender: Male',
          style: _infoText),
      Text('Rol: ${_actor.knownForDepartment}', style: _infoText),
      Text('Born in: ${_actor.placeOfBirth}', style: _infoText , overflow: TextOverflow.ellipsis,),
      Text('BirthDay: ${_actor.birthday}', style: _infoText),
//      Text( ' '),
      Text(_actor.deathday == null ? ' ' : 'DeathDay: ${_actor.deathday}',
          style: _infoText),
//                    Text(_actor.deathday),
    ]);
  }

  Widget _actorBio(BuildContext context, String bio) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: Text(bio,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1),
    );
  }
}

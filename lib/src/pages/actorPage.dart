import 'package:flutter/material.dart';
import 'package:porfolio_movies_app/src/models/castingModel.dart';
import 'package:porfolio_movies_app/src/providers/actors_Provider.dart';

class ActorPage extends StatelessWidget {
  static String id = 'actorPage';

  @override
  Widget build(BuildContext context) {
    ActorsProvider actorsProvider = ActorsProvider();
    Actor actor = ModalRoute.of(context).settings.arguments;
    if (actor == null) {
      actor = ActorsProvider.dummyActor;
    }

    return Scaffold(
      body: FutureBuilder(
          future: actorsProvider.getActor(actor.id),
          builder: (BuildContext context, AsyncSnapshot<Actor> snapshot) {
            if (snapshot.hasData) {
              final Actor _actor = snapshot.data;
              return CustomScrollView(
                slivers: [
                  _sliverAppBar(actor),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        //_heroActor(context, _actor),
                        _actorBio(context, _actor),
                        Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
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

  SliverAppBar _sliverAppBar(Actor actor) {
    return SliverAppBar(
      elevation: 2.0,
      centerTitle: true,
      floating: false,
      pinned: true,
      expandedHeight: 400.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(actor.name),
        centerTitle: true,
        background: FadeInImage(
          fadeInDuration: Duration(milliseconds: 150),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(actor.getProfileImage()),
        ),
      ),
    );
  }

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
      Text(
        'Born in: ${_actor.placeOfBirth}',
        style: _infoText,
        overflow: TextOverflow.ellipsis,
      ),
      Text('BirthDay: ${_actor.birthday}', style: _infoText),
//      Text( ' '),
      Text(_actor.deathday == null ? ' ' : 'DeathDay: ${_actor.deathday}',
          style: _infoText),
//                    Text(_actor.deathday),
    ]);
  }

  Widget _actorBio(BuildContext context, Actor actor) {
    SizedBox separatorWidget = SizedBox(height: 5.0);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Biography', style: Theme.of(context).textTheme.headline5),
          separatorWidget,
          Text(actor.biography,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.subtitle1),
          separatorWidget,
          Text('Personal Info', style: Theme.of(context).textTheme.headline6),
          separatorWidget,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: actorInfoCard(actor, context),
          )
        ],
      ),
    );
  }

  Widget actorInfoCard(Actor _actor, BuildContext context) {
    final TextStyle _infoText = Theme.of(context).textTheme.subtitle1;
    final _width = MediaQuery.of(context).size.width;

    Widget _myColumn(String title, String info) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            info,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 15.0),
          //Divider(height: 2.0),
          Container(
            color: Colors.black12,
            //margin: EdgeInsets.symmetric(horizontal:10.0),
            height: 1.0,
          ),
          SizedBox(height: 15.0),
        ],
      );
    }

    return Card(
      child: Container(
        width: _width,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _myColumn('Gender', _actor.gender == 1 ? 'Female' : 'Male'),
            _myColumn('Born in', _actor.placeOfBirth),
            _myColumn('Birthday', _actor.birthday),
            if (_actor.deathday != null)
              _myColumn('Deathday', _actor.deathday),

            //Text('Rol: ${_actor.knownForDepartment}', style: _infoText),
            _myColumn('Known for', _actor.knownForDepartment),
          ],
        ),
      ),
    );
  }
}

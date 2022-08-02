import 'package:breaking_bad/models.dart';
import 'package:breaking_bad/quotes_screen.dart';
import 'package:flutter/material.dart';

class CharacterTile extends StatelessWidget {
  late Character character;

  CharacterTile(data, {super.key}) {
    character = Character.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => QuotesScreen(character.id)));
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(character.imgUrl),
                      fit: BoxFit.cover)),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.only(top: 150, right: 3),
              child: Text(
                '${character.name}',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white, fontSize: 19),
              ),
            )));
  }
}

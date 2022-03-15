import 'character_details_view.dart';
import '../bloc/characters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jabu_code_challenge/src/domain/entities/character.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharacterState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Rick and Morty Code Challenge')),
            body: PaginationView<Character>(
                itemBuilder: (context, character, index) => ListTile(
                    title: Text(character.name!),
                    subtitle: Text(character.species!),
                    onTap: () {
                      context
                          .read<CharactersBloc>()
                          .getCharacterDetails(int.parse(character.id!))
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) => CharacterDetailsView(characterDetails: value)));
                      });
                    },
                    leading: Hero(
                      tag:'${character.id}',
                      child: CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(character.image!)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined)),
                pageFetch: context.read<CharactersBloc>().getCharactersInPage,
                onEmpty: const Center(child: Text('No characters left')),
                onError: (exception) =>
                    const Center(child: Text('An error has been occured')))));
  }
}

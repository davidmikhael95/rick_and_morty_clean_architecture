import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jabu_code_challenge/src/domain/entities/character_details.dart';

class CharacterDetailsView extends StatelessWidget {
  final CharacterDetails? characterDetails;
  const CharacterDetailsView({Key? key, required this.characterDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey.shade800,
      navigationBar: CupertinoNavigationBar(
          middle: Text(characterDetails!.name!),
          automaticallyImplyLeading: true),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Hero(
                         tag:'${characterDetails!.id}',
                          child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  CachedNetworkImageProvider(characterDetails!.image!)),
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(characterDetails!.name!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(characterDetails!.species!,
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    children: ListTile.divideTiles(
                        color: Colors.blue,
                        context: context,
                        tiles: [
                          ListTile(
                              title: const Text('Gender'),
                              trailing: Text(characterDetails!.gender!)),
                          ListTile(
                              title: const Text('Status'),
                              trailing: Text(characterDetails!.status!)),
                          ListTile(
                              title: const Text('Type'),
                              trailing: Text(characterDetails!.type!)),
                          ListTile(
                              title: const Text('Appearance count in Episodes'),
                              trailing: Text(characterDetails!.episodes!.length
                                  .toString())),
                          const SizedBox(height: 30),
                        ]).toList(),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics:const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2 / 2,
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: characterDetails!.episodes!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return CircleAvatar(
                          backgroundColor: Colors.green.shade500,
                          child: Center(
                              child: Text(
                            characterDetails!.episodes![index].name!,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            textScaleFactor: 1.2,
                            style: const TextStyle(color: Colors.white),
                          )),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

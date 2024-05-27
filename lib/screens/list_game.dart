import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:game_tracker/models/game.dart';
import 'package:game_tracker/widgets/left_drawer.dart';

class GamePage extends StatefulWidget {
    const GamePage({Key? key}) : super(key: key);

    @override
    State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
Future<List<Game>> fetchBook() async {
    var url = Uri.parse(
        'http://10.0.2.2//json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Game> listGame = [];
    for (var d in data) {
        if (d != null) {
            listGame.add(Game.fromJson(d));
        }
    }
    return listGame;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Game'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchBook(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                        return const Column(
                            children: [
                                Text(
                                    "Tidak ada data game.",
                                    style: TextStyle(
                                        color: Color(0xff59A5D8),
                                        fontSize: 20
                                    ),
                                ),
                                SizedBox(height: 8),
                            ],
                        );
                    } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12
                                ),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(
                                            "${snapshot.data![index].fields.name}",
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.page}"),
                                        const SizedBox(height: 10),
                                        Text("${snapshot.data![index].fields.description}")
                                    ],
                                ),
                            ),
                        );
                    }
                }
            }),
        );
    }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_tracker/screens/menu.dart';
import 'package:game_tracker/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';




class TrackerFormPage extends StatefulWidget {
    const TrackerFormPage({super.key});

    @override
    State<TrackerFormPage> createState() => _TrackerFormPageState();
}

class _TrackerFormPageState extends State<TrackerFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
    int _price = 0;
    String _description = "";
    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
        return Scaffold(
    appBar: AppBar(
        title: const Center(
            child: Text(
            'Form Tambah Game',
            ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        ),
        drawer: const LeftDrawer(),
        body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Judul Game",
                    labelText: "Judul Game",
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    ),
                ),
                onChanged: (String? value) {
                    setState(() {
                    _title = value!;
                    });
                },
                validator: (String? value) {
                    if (value == null || value.isEmpty) {
                    return "Judul tidak boleh kosong!";
                    }
                    return null;
                },
            ),
        ),
        Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        decoration: InputDecoration(
            hintText: "Harga",
            labelText: "Harga",
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            ),
        ),
        onChanged: (String? value) {
            setState(() {
            _price = int.tryParse(value!) ?? 0;
            });
        },
        validator: (String? value) {
            if (value == null || value.isEmpty) {
                return "Harga tidak boleh kosong!";
            }
            if (int.tryParse(value) == null) {
                return "Harga harus berupa angka!";
            }
            return null;
        },
    ),
),
Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        decoration: InputDecoration(
            hintText: "Deskripsi",
            labelText: "Deskripsi",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
            ),
        ),
        onChanged: (String? value) {
            setState(() {
            _description = value!;
            });
        },
        validator: (String? value) {
            if (value == null || value.isEmpty) {
            return "Deskripsi tidak boleh kosong!";
            }
            return null;
        },
    ),
),
Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
            ),
            onPressed: () async {
            if (_formKey.currentState!.validate()) {
                showDialog(
                    context: context,
                    builder: (context) {
                        return AlertDialog(
                            title: const Text('Game berhasil tersimpan'),
                            content: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Text('Judul: $_title'),
                                        Text('Harga: $_price'),
                                        Text('Deskripsi: $_description'),
                                    ],
                                ),
                            ),
                            actions: [
                                TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                        Navigator.pop(context);
                                        _formKey.currentState!.reset();
                                    },
                                ),
                            ],
                        );
                    },
                );
            }
            if (_formKey.currentState!.validate()) {
        final response = await request.postJson(
            "http://10.0.2.2//create-flutter/",
            jsonEncode(<String, String>{
                'title': _title,
                'price': _price.toString(),
                'description': _description,
            }),
        );
        if (context.mounted) {
            if (response['status'] == 'success') {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                content: Text("Game baru berhasil disimpan!"),
                ));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                );
            } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(
                    content:
                        Text("Terdapat kesalahan, silakan coba lagi."),
                ));
            }
        }
    }
            },
            child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
            ),
        ),
    ),
),
        ]
        )
          ),
        
        ),
    );
    }
}
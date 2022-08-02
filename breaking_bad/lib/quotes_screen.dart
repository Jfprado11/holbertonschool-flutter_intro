import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuotesScreen extends StatelessWidget {
  int? id;

  QuotesScreen(int this.id, {super.key});

  Future<List<dynamic>> fetchQuote(id) async {
    try {
      var urlChar =
          Uri.parse('https://www.breakingbadapi.com/api/characters/$id');
      final responseChar = await http.get(urlChar);
      var data = jsonDecode(responseChar.body);
      String name = data[0]['name'].replaceAll(' ', '+');
      var urlQuotes =
          Uri.parse('https://www.breakingbadapi.com/api/quote?author=$name');
      final responseQuotes = await http.get(urlQuotes);
      return jsonDecode(responseQuotes.body);
    } catch (err) {
      throw Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Text('hola $id'),
      body: FutureBuilder<List<dynamic>>(
        future: fetchQuote(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data?[index]['quote']}'),
                  );
                });
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

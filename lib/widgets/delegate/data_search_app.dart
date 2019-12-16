import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Teste extends SearchDelegate<String>{


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(

        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon:  AnimatedIcons.menu_arrow,
        progress:transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      color: Colors.black87,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
      return Container(
        color: Colors.black,
      );
    } else {
      return FutureBuilder<dynamic>(
        future: suggestions(query),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.black,
                ),
                strokeWidth: 10.0,
              ),
            );
          } else {
            return ListView.builder(itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data[index]),
                leading: Icon(Icons.play_arrow),
                onTap: (){
                  close(context,snapshot.data[index]);
                },
              );
            },
              itemCount: snapshot.data.length,
            );
          }
        },
      );
    }
  }


  suggestions(String search) async {
    http.Response response = await http.get("https://api.themoviedb.org/3/search/movie?api_key=c5850ed73901b8d268d0898a8a9d8bff&language=en-US&query=$search&page=1&include_adult=false");
    
    if(response.statusCode == 200){
      jsonDecode(response.body)["results"].map((v){
        return v["original_title"];
      }).toList();
    } else {
      throw Exception("Error!");
    }
    
  }

}
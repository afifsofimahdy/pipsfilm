import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pipmovie/material/url.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getSearch() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map movie in responseJson['results']) {
        _movieDetails.add(UserDetails.fromJson(movie));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getSearch();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body:  Column(
          children: <Widget>[
             Container(
              color: Colors.orange,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Card(
                  child:  ListTile(
                    leading:  Icon(Icons.search),
                    title:  TextField(
                      controller: controller,
                      decoration:  InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing:  IconButton(icon:  Icon(Icons.cancel), 
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),
             Expanded(
              child: _searchResult.length != 0 || controller.text.isNotEmpty
                  ?  ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, i) {
                  return  Card(
                    child:  ListTile(
                      leading:  CircleAvatar(backgroundImage:  NetworkImage(_searchResult[i].banner,),),
                      title:  Text(_searchResult[i].title + ' ' + _searchResult[i].oriTitle),
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              )
                  :  ListView.builder(
                itemCount: _movieDetails.length,
                itemBuilder: (context, index) {
                  return  Card(
                    child:  ListTile(
                      leading:  CircleAvatar(backgroundImage:  NetworkImage(_movieDetails[index].banner,),),
                      title:  Text(_movieDetails[index].title + ' ' + _movieDetails[index].oriTitle),
                    ),
                    margin: const EdgeInsets.all(0.0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _movieDetails.forEach((movieDetail) {
      if (movieDetail.title.contains(text) || movieDetail.oriTitle.contains(text))
        _searchResult.add(movieDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _movieDetails = [];

final String url = 'https://api.themoviedb.org/3/search/movie?query=marvel&api_key=fbb9572d11b5458ac98f02b84f2bafc4';
class UserDetails {
  final int id;
  final String title, oriTitle, banner;

  UserDetails({this.id, this.title, this.oriTitle, this.banner,});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return  UserDetails(
      id: json['id'],
      title: json['title'],
      oriTitle: json['original_title'],
      banner:json['backdrop_path'] != null ? "$loadImage${json['backdrop_path']}" : "$erorLoadImage" 
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pipmovie/widget/botomsheet_detail.dart';
import 'package:pipmovie/material/url.dart';
import 'package:pipmovie/model.dart/moviemodel.dart';
import 'package:pipmovie/screen/search.dart';
import 'package:pipmovie/widget/chips.dart';
import 'package:pipmovie/widget/custom.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({ Key key }) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Result> dataRecomMovie = List();
  bool loadgambarRecom = true;
  List<Result> dataNowPlayMovie = List();
  bool loadgambarNowPlay = true;
  List<Result> dataTerpopuler= List();
  bool load= true;
  bool isSearching = false;
  TextEditingController search = new TextEditingController();



  @override
  void initState() {
    super.initState();
    _fetchDataplayMovie();
    _fetchDataRecomMovie();
    _fetchDataPopularMovie();
  }



  Future<Null> _fetchDataRecomMovie() async{
    final response = await http.get(getrecommendationsMovie);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataRecomMovie.add(Result.fromJson(i));
          setState(() {
            loadgambarRecom = false;
          });
        }
      });
      
    }
  }

  Future<Null> _fetchDataplayMovie() async{
    final response = await http.get(getNowPlayingMovie);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataNowPlayMovie.add(Result.fromJson(i));
          setState(() {
            loadgambarNowPlay = false;
          });
        }
      });
      
    }
  }

  Future<Null> _fetchDataPopularMovie() async{
    final response = await http.get(getPopularMovie);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataTerpopuler.add(Result.fromJson(i));
          setState(() {
            load = false;
          });
        }
      });
      
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children :[
              AppBar(
                backgroundColor: Color(0xFF1B2C3B),
                elevation: 0.0,
                title: Text("Pips Movies"),
                actions: [
                  GestureDetector(
                    onTap: ()=> Get.to(SearchPage()),
                    child: Row(
                      children: [
                        Text("Cari film"),
                        Icon(Icons.search),
                      ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
               isSearching ? SizedBox() : Column(
                children: [
                  ChipsCustom(),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Sedang Tayang",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Lainya..",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  loadgambarNowPlay ? CircularProgressIndicator() : Container(
                    width: double.infinity,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: dataNowPlayMovie.length,
                      itemBuilder: (context, index) {
                        return InfoCard(
                          loading: loadgambarNowPlay,
                          title: dataNowPlayMovie[index].title,
                          rate: dataNowPlayMovie[index].voteAverage.toString().substring(0, 3),
                          date: dataNowPlayMovie[index].releaseDate.toString().substring(0, 11),
                          banner: dataNowPlayMovie[index].backdropPath != null ? "$loadImage${dataNowPlayMovie[index].backdropPath}" : erorLoadImage,
                          onpress: () async {
                            await Functions().showBottomSheetDialog(
                              context: context,
                              image: '$loadImage${dataNowPlayMovie[index].posterPath}',
                              rating: dataNowPlayMovie[index].voteAverage.toString().substring(0, 3),
                              judul: dataNowPlayMovie[index].originalTitle,
                              deskripsi: dataNowPlayMovie[index].overview,
                            );
                          },
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Lainya..",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  loadgambarRecom ? CircularProgressIndicator() : Container(
                    width: double.infinity,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: dataRecomMovie.length,
                      itemBuilder: (context, index) {
                        return InfoCard(
                          loading: loadgambarRecom,
                          title: dataRecomMovie[index].title,
                          rate: dataRecomMovie[index].voteAverage.toString().substring(0, 3),
                          date: dataRecomMovie[index].releaseDate.toString().substring(0, 11),
                          banner: dataRecomMovie[index].backdropPath != null ? "$loadImage${dataRecomMovie[index].backdropPath}" : erorLoadImage,
                          onpress: () async {
                            await Functions().showBottomSheetDialog(
                              context: context,
                              image: '$loadImage${dataRecomMovie[index].posterPath}',
                              rating: dataRecomMovie[index].voteAverage.toString().substring(0, 3),
                              judul: dataRecomMovie[index].originalTitle,
                              deskripsi: dataRecomMovie[index].overview,
                            );
                          },
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Terpopuler",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Padding(
                        padding:EdgeInsets.only(left: 12),
                        child: Text(
                          "Lainya..",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  load ? CircularProgressIndicator() : Container(
                    width: double.infinity,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: dataTerpopuler.length,
                      itemBuilder: (context, index) {
                        return InfoCard(
                          loading: load,
                          title: dataTerpopuler[index].title,
                          rate: dataTerpopuler[index].voteAverage.toString().substring(0, 3),
                          date: dataTerpopuler[index].releaseDate.toString().substring(0, 11),
                          banner: dataTerpopuler[index].backdropPath != null ? "$loadImage${dataTerpopuler[index].backdropPath}" : erorLoadImage,
                          onpress:  () async {
                            await Functions().showBottomSheetDialog(
                              context: context,
                              image: '$loadImage${dataTerpopuler[index].posterPath}',
                              rating: dataTerpopuler[index].voteAverage.toString().substring(0, 3),
                              judul: dataTerpopuler[index].originalTitle,
                              deskripsi: dataTerpopuler[index].overview,
                            );
                          },
                        );
                      }
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80,),
            ] 
          ),
        ),
      ),
    );
  }
}
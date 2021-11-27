import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pipmovie/widget/botomsheet_detail.dart';
import 'package:pipmovie/material/url.dart';
import 'package:pipmovie/model.dart/modeltv.dart';
import 'package:pipmovie/screen/search.dart';
import 'package:pipmovie/widget/chips.dart';
import 'package:pipmovie/widget/custom.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TvPage extends StatefulWidget {
  const TvPage({ Key key }) : super(key: key);

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  List<ResultTv> dataRecomTv = List();
  bool loadgambarRecom = true;
  List<ResultTv> dataNowPlayTv = List();
  bool loadgambarNowPlay = true;
  List<ResultTv> dataTerpopuler= List();
  bool load= true;



  @override
  void initState() {
    super.initState();
    _fetchDataplayMovie();
    _fetchDataRecomMovie();
    _fetchDataPopularMovie();
  }



  Future<Null> _fetchDataRecomMovie() async{
    final response = await http.get(getTvRecomend);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataRecomTv.add(ResultTv.fromJson(i));
          setState(() {
            loadgambarRecom = false;
          });
        }
      });
      
    }
  }

  Future<Null> _fetchDataplayMovie() async{
    final response = await http.get(getOnTheAir);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataNowPlayTv.add(ResultTv.fromJson(i));
          setState(() {
            loadgambarNowPlay = false;
          });
        }
      });
      
    }
  }

  Future<Null> _fetchDataPopularMovie() async{
    final response = await http.get(getTvPopular);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      setState(() {
        for( Map i in data['results']){
          dataTerpopuler.add(ResultTv.fromJson(i));
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
                  itemCount: dataNowPlayTv.length,
                  itemBuilder: (context, index) {
                    return InfoCard(
                      loading: loadgambarNowPlay,
                      title: dataNowPlayTv[index].name,
                      rate: dataNowPlayTv[index].voteAverage.toString().substring(0, 3),
                      date: dataNowPlayTv[index].firstAirDate.toString().substring(0, 11),
                      banner: dataNowPlayTv[index].backdropPath != null ? "$loadImage${dataNowPlayTv[index].backdropPath}" : erorLoadImage,
                      onpress: () async {
                        await Functions().showBottomSheetDialog(
                          context: context,
                          image: '$loadImage${dataNowPlayTv[index].posterPath}',
                          rating: dataNowPlayTv[index].voteAverage.toString().substring(0, 3),
                          judul: dataNowPlayTv[index].name,
                          deskripsi: dataNowPlayTv[index].overview,
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
                  itemCount: dataRecomTv.length,
                  itemBuilder: (context, index) {
                    return InfoCard(
                      loading: loadgambarRecom,
                      title: dataRecomTv[index].name,
                      rate: dataRecomTv[index].voteAverage.toString().substring(0, 3),
                      date: dataRecomTv[index].firstAirDate.toString().substring(0, 11),
                      banner: dataRecomTv[index].backdropPath != null ? "$loadImage${dataRecomTv[index].backdropPath}" : erorLoadImage,
                      onpress: () async {
                        await Functions().showBottomSheetDialog(
                          context: context,
                          image: '$loadImage${dataRecomTv[index].posterPath}',
                          rating: dataRecomTv[index].voteAverage.toString().substring(0, 3),
                          judul: dataRecomTv[index].name,
                          deskripsi: dataRecomTv[index].overview,
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
                      title: dataTerpopuler[index].name,
                      rate: dataTerpopuler[index].voteAverage.toString().substring(0, 3),
                      date: dataTerpopuler[index].firstAirDate.toString().substring(0, 11),
                      banner: dataTerpopuler[index].backdropPath != null ? "$loadImage${dataTerpopuler[index].backdropPath}" : erorLoadImage,
                      onpress: () async {
                        await Functions().showBottomSheetDialog(
                          context: context,
                          image: '$loadImage${dataTerpopuler[index].posterPath}',
                          rating: dataTerpopuler[index].voteAverage.toString().substring(0, 3),
                          judul: dataTerpopuler[index].name,
                          deskripsi: dataTerpopuler[index].overview,
                        );
                      },
                    );
                  }
                ),
              ),
              SizedBox(height: 80,),
            ] 
          ),
        ),
      ),
    );
  }
}
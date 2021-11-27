import 'package:flutter/material.dart';
import 'package:pipmovie/material/color.dart';

class CAppBar extends StatelessWidget {
  const CAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: theme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        height: 80,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:  NetworkImage(
                            'https://dafunda.com/wp-content/uploads/2021/09/fakta-unik-saitama-one-punch-man.jpg'
                          ),
                        )
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hai..",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          Text(
                            "Afif Sofi Mahdy",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
            ],
          ),
          SizedBox(height: 32),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide( color: Colors.grey,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                    hintText: "Coba cari judul film" ,
                    hintStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.white,),
                      onPressed: null,
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
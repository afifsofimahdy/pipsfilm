import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class NotInternetPage extends StatelessWidget {
  const NotInternetPage({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
          content: Text('Tekan lagi untuk keluar'),
        ),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset('assets/oops.jpg')
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Ya internetmu sedang ada masalah coba perbaiki agar dapat terus menikmati film kami",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
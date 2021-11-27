import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:pipmovie/screen/noConectitivityInternet.dart';
import 'package:pipmovie/material/color.dart';
import 'package:pipmovie/screen/movie.dart';
import 'package:pipmovie/screen/tv.dart';
import 'package:connectivity/connectivity.dart';

class MainPageController extends GetxController {
  static String tag = "main-page-controller";
  Rx<PageController> pageController = PageController().obs;
  RxInt currentTab = 0.obs;
  RxBool internet = false.obs;
  StreamSubscription subscription;


  @override
  void onInit() {
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
    super.onInit();
  }
  showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'Anda memakai $result'
        : 'Saat ini perangkat tidak tersambung internet';

    
    if(!hasInternet){
      internet = false.obs;
      Get.snackbar(
        "Koneksi anda bermasalah",
        "$message",
        duration: const Duration(milliseconds: 4000),
        backgroundColor: Colors.red,
        colorText: Colors.black.withOpacity(0.7),
        padding: EdgeInsets.all(14),
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(25),
        forwardAnimationCurve: Curves.easeInOut,
        reverseAnimationCurve: Curves.easeOut,
        boxShadows: [
          BoxShadow(
            offset: Offset(0, 3),
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8
          )
        ],
      );
      Get.to(()=> NotInternetPage());
    } else {
      internet = true.obs;
    }


  }
  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({ Key key }) : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(40)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.fromLTRB(18, 22, 18, 22);
  SnakeShape snakeShape = SnakeShape.indicator;
  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;
  Color selectedColor = Colors.orange;
  Gradient selectedGradient = const LinearGradient(colors: [Colors.red, Colors.amber]);
  Color unselectedColor = Colors.white;
  MainPageController mainPageController = Get.put(MainPageController(), tag: MainPageController.tag);

  @override
  void initState() {
    mainPageController.pageController.value = new PageController(initialPage: 0);
    mainPageController.currentTab.value = 0;    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: mainPageController.pageController.value,
            children: [
              MoviePage(),
              TvPage(),
            ],
            physics: NeverScrollableScrollPhysics(),
          ),
          Obx(() =>Align(
              alignment: Alignment.bottomCenter,
              child: SnakeNavigationBar.color(
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.3),
                behaviour: snakeBarStyle,
                snakeShape: snakeShape,
                shape: bottomBarShape,
                padding: padding,
                backgroundColor: theme,

                snakeViewColor: selectedColor,
                selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
                unselectedItemColor: Colors.white,

                showUnselectedLabels: showUnselectedLabels,
                showSelectedLabels: showSelectedLabels,
                selectedLabelStyle: TextStyle(fontSize: 12),
                unselectedLabelStyle: TextStyle(fontSize: 12),

                currentIndex: mainPageController.currentTab.value,
                onTap: (index) {
                  setState(() => mainPageController.currentTab.value = index);
                  mainPageController.pageController.value.jumpToPage(index);
                },
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movie'),
                  BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Tv'),
                ],
              ),
            )),
        ],
      ),
    );
  }
}
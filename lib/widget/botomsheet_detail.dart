import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../material/color.dart';
import '../material/url.dart';

class Functions {
  Future<void> showBottomSheetDialog({BuildContext context, String judul, String rating, String image, String deskripsi}) async {
    final SheetController sheetController = SheetController();
    await showSlidingBottomSheet(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          cornerRadius: 12,
          cornerRadiusOnFullscreen: 0.0,
          controller: sheetController,
          duration: const Duration(milliseconds: 500),
          snapSpec: const SnapSpec(
            snap: true,
            initialSnap: 1,
          ),
          scrollSpec: const ScrollSpec(
            showScrollbar: true,
          ),
          avoidStatusBar: true,
          color: Colors.white,
          maxWidth: 500,
          isDismissable: true,
          dismissOnBackdropTap: true,
          isBackdropInteractable: true,
          onDismissPrevented: (backButton, backDrop) async {
            if (backButton || backDrop) {
              Get.back();
            }
          },
          builder: (context, state) {
            return Material(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: theme,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                                image ?? erorLoadImage,
                                fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(-0, 0.8),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: theme,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3),
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40, left: 8),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(judul,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text("rating " + rating,
                                      style: TextStyle(
                                        color: Colors.grey[200],
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(deskripsi,
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: FloatingActionButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back),
                        backgroundColor: Colors.orange,
                        focusColor: theme,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
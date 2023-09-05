import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../themes/color_theme.dart';
import 'controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(width: Get.width, height: Get.height),
            Column(
              children: [
                Row(
                  children: [
                    _googleMapWidget("Itaewon, Seoul"),
                    _googleMapWidget("Gangnam, Seoul"),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  height: 8,
                ),
                Row(
                  children: [
                    _googleMapWidget("Banpo, Seoul"),
                    _googleMapWidget("Gangbuk, Seoul"),
                  ],
                ),
              ],
            ),
            Container(
              width: 1,
              height: Get.height,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  _googleMapWidget(String cityName) => Stack(
    children: [
      Container(
        width: (Get.width / 2) - 4,
        height: (Get.height / 2) - 4,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: controller.initPosition,
          myLocationButtonEnabled: false,
          onMapCreated: controller.onGoogleMapCreated,
          onLongPress: controller.onGoogleMapLongTab,
          onCameraMove: controller.updateCameraPosition,
        ),
      ),
      Positioned(
        top: 16,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(75),
                offset: Offset(0, 4),
                blurRadius: 25,
                spreadRadius: 2
              )
            ]
          ),
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text("$cityName"),
          ),
        ),
      ),
    ],
  );

}






import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageController extends GetxController with StateMixin {
  Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
  Rx<MapType> mapVisibleType = MapType.normal.obs;

  CameraPosition initPosition = const CameraPosition(
    target: LatLng(50.8439511837857, 4.357298295209326),
    zoom: 18,
  );

  late CameraPosition latestUpdatePosition;
  late Position _currentPosition;


  Rx<Function> floatingBtnClick = () {}.obs;
  Rx<Widget> floatingBtnIcon = const Icon(Icons.add, color: Colors.white, size: 48).obs;


  RxList medicalFacilitiesList = [].obs;

  @override
  void onInit() async {
    latestUpdatePosition = initPosition;

    //Permission.locationWhenInUse.request();

    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    initPosition = CameraPosition(
      target: LatLng(_currentPosition.longitude, _currentPosition.latitude),
      zoom: 18,
    );


    change(null, status: RxStatus.success());
    super.onInit();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _currentPosition = position;
  }

  void onGoogleMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  void onGoogleMapLongTab(LatLng pos) {
    if (mapVisibleType.value == MapType.normal) {
      mapVisibleType.value = MapType.hybrid;
    } else if (mapVisibleType.value == MapType.hybrid) {
      mapVisibleType.value = MapType.normal;
    }
  }

  void updateCameraPosition(CameraPosition nowPosition) {
    List<double> nowPoistionCoordList = [
      nowPosition.target.latitude,
      nowPosition.target.longitude
    ];

    double positionDistance = _getDistance(
      nowPoistionCoordList,
      [
        latestUpdatePosition.target.latitude,
        latestUpdatePosition.target.longitude
      ]
    );

    if (positionDistance > 500 && nowPosition.zoom > 14) {
      //showPolylineOnGoogleMap(nowPoistionCoordList, (130 * (20 - nowPosition.zoom)).toInt());
      latestUpdatePosition = nowPosition;
    }
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  double _getDistance(List<double> coord1, List<double> coord2) {
    double lat1 = coord1[0];
    double lon1 = coord1[1];
    double lat2 = coord2[0];
    double lon2 = coord2[1];

    double theta = lon1 - lon2;
    double dist = sin(_deg2rad(lat1)) * sin(_deg2rad(lat2)) + cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * cos(_deg2rad(theta));
    dist = acos(dist);
    dist = _rad2deg(dist);
    dist = dist * 60 * 1.1515 * 1.609344 * 1000; // 거리 단위를 m로 변환

    return (dist);
  }

  double _deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  double _rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

}

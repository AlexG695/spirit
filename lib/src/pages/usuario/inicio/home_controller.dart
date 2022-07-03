import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/provider/push_notification_provider.dart';
import 'package:integradora/src/provider/users_provider.dart';
import 'package:integradora/src/utils/shared_pref.dart';
import 'package:location/location.dart' as location;

class HomeController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function refresh;
  Position _position;
  User user;
  String locate;
  File imageFile;
  String addressName;
  String locating;
  LatLng addressLatLng;

  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(28.6426341, -106.0695091), zoom: 13);

  Completer<GoogleMapController> _mapController = Completer();

  PushNotificationsProvider pushNotificationsProvider =
      PushNotificationsProvider();
  UsersProvider _usersProvider = new UsersProvider();
  List<String> tokens = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    user = User.fromJson(await _sharedPref.read('user'));
    _usersProvider.init(context, sessionUser: user);

    //tokens = await _usersProvider.getAdminsNotificationTokens();
    //sendNotification();
    refresh();
  }

  void selectRefPoint() {
    Map<String, dynamic> data = {
      'address': addressName,
      'lat': addressLatLng.latitude,
      'lng': addressLatLng.longitude,
    };

    Navigator.pop(context, data);
  }

  Future<Null> setLocationDraggableInfo() async {
    if (initialPosition != null) {
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark> address = await placemarkFromCoordinates(lat, lng);

      if (address != null) {
        if (address.length > 0) {
          String direction = address[0].thoroughfare;
          String street = address[0].subThoroughfare;
          String city = address[0].locality;
          String department = address[0].administrativeArea;
          String country = address[0].country;

          addressName = '$direction, $street, $city, $department, $country';
          addressLatLng = new LatLng(lat, lng);
          locating = '$city';

          refresh();
        }
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle('[]');
    _mapController.complete(controller);
  }

  void updateLocation() async {
    try {
      await _determinePosition(); //OBTIENE UBICACIÓN ACTUAL Y PERMISOS
      _position = await Geolocator.getLastKnownPosition(); //LAT Y LNG
      animatedCameraToPosition(_position.latitude, _position.longitude);
    } catch (e) {
      print('Error: $e');
    }
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationEnabled) {
      updateLocation();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
      }
    }
  }

  Future animatedCameraToPosition(double lat, double lng) async {
    GoogleMapController controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15, bearing: 0)));
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToProfile() {
    Navigator.pushNamed(context, 'profile');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToSupport() {
    Navigator.pushNamed(context, 'support');
  }

  void goToAbout() {
    Navigator.pushNamed(context, 'about');
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/network/api_provider.dart';
import 'package:rider/services/location.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';
import 'package:rider/shared/config_map.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {
  double uiLatitude;
  double uiLongitude;
  double bottomPaddingOfTheMap = 340.0;
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _googleMapController = Completer();

  // move or animate the camera on google map
  moveCamera(){
    // first i get the new CameraPosition
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(uiLatitude, -uiLongitude),
      zoom: 14,
    );
    // second animate and update the camera via newGoogleMapController
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }

  @override
  void initState() {
    LocationService.getCurrentLocationPosition().then((value) {
      uiLatitude = LocationService.latitude;
      uiLongitude = LocationService.longitude;
    });
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kForthColor,
      drawer: Drawer(
        child: Container(
          color: kForthColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // header
              Container(
                height: 280,
                child: DrawerHeader(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/user_icon.png',
                        scale: 3,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Profile Name',
                          style: TextStyle(
                              fontSize: 28, fontFamily: 'Signatra')),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kMainColor,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.history, color: kMainColor,),
                title: Text('History'),
                onTap: () {
                  ApiProvider.getAPIProviderInstance.fetchData(
                    lat: uiLatitude,
                    long: uiLongitude,
                    mapKey: kMapKeyForIOS,
                  ).then((value) {
                    print('======================== Hello From init State');
                    print(value.data['results'][0]['formatted_address']);
                  });
                },
              ),
              drawDivider(),
              ListTile(
                leading: Icon(Icons.person, color: kMainColor,),
                title: Text('Visit Profile'),
                onTap: () {
                  print('= = = = = = = = = => $uiLatitude');
                  print('= = = = = = = = = => $uiLatitude');
                },
              ),
              drawDivider(),
              ListTile(
                leading: Icon(Icons.info, color: kMainColor,),
                title: Text('About'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              drawDivider(),
              ListTile(
                leading: Icon(Icons.logout, color: kMainColor,),
                title: Text('Logout'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              drawDivider(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfTheMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _googleMapController.complete(controller);
                newGoogleMapController = controller;
                setState(() {
                  bottomPaddingOfTheMap = 340.0;
                });
                moveCamera();
              },
            ),
            // Hamburger button for drawer
            Positioned(
              left: 22.0,
              top: 22.0,
              child: GestureDetector(
                onTap: (){
                  scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: [
                        BoxShadow(
                            color: kForthColor,
                            blurRadius: 3.0,
                            offset: Offset(0.1, 0.1),
                            spreadRadius: 0.1)
                      ]),
                  child: CircleAvatar(
                    backgroundColor: kMainColor,
                    child: Icon(Icons.menu, color: kForthColor,),
                    radius: 20.0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(
                height: 340,
                decoration: BoxDecoration(
                    color: kForthColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: kMainColor,
                          blurRadius: 3.0,
                          offset: Offset(0.7, 0.7),
                          spreadRadius: 0.3)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Hello There,',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Where To?',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'BoltSemiBold'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kForthColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                  color: kMainColor,
                                  blurRadius: 1.0,
                                  offset: Offset(0.1, 0.1),
                                  spreadRadius: 1.0)
                            ]),
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: kMainColor,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Search Drop Off',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: kMainColor,
                            size: 35,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Home',
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Your Living Address',
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 12.0,
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      drawDivider(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work,
                            color: kMainColor,
                            size: 35,
                          ),
                          SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Work',
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                'Your Office Address',
                                style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 12.0,
                                    fontFamily: 'Muli',
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

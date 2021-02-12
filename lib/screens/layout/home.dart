import 'dart:async';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/network/api_provider.dart';
import 'package:rider/screens/layout/cubit/home_cubit.dart';
import 'package:rider/screens/layout/cubit/home_states.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';
import 'package:rider/shared/config_map.dart';

class HomePage extends StatelessWidget  {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _googleMapController = Completer();
  final CameraPosition _kInitialCameraPosition = CameraPosition(
    target: LatLng(31.043567, 31.3770272),
    zoom: 14.5,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getCurrentLocation(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state){},
        builder: (context, state) {
          GoogleMapController newGoogleMapController;
          double uiLatitude = HomeCubit.get(context).cubitLatitude;
          double uiLongitude = HomeCubit.get(context).cubitLongitude;


          return ConditionalBuilder(
          condition: state is! HomeLoadingState,
          builder: (context) => Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          initialCameraPosition: _kInitialCameraPosition,
                          onMapCreated: (GoogleMapController controller) {
                            _googleMapController.complete(controller);
                            newGoogleMapController = controller;
                            _moveCamera(newGoogleMapController,uiLatitude, uiLongitude);
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
                      ],
                    ),
                  ),
                  Container(
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
                ],
              ),
            ),
          ),
        );
        },
      ),
    );
  }

  // move or animate the camera on google map
  _moveCamera(controller, lat, long){
    // first i get the new CameraPosition
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14,
    );
    // second animate and update the camera via newGoogleMapController
    controller.animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
  }
}

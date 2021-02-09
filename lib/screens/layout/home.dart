import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';

class HomePage extends StatelessWidget {

  Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kForthColor,
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller){
            _googleMapController.complete(controller);
            newGoogleMapController = controller;
          },
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
                BoxShadow(color: kMainColor,
                  blurRadius: 3.0,
                  offset: Offset(0.7,0.7),
                  spreadRadius: 0.3
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0,),
                  Text('Hello There,', style: TextStyle(fontSize: 12),),
                  Text('Where To?', style: TextStyle(fontSize: 20, fontFamily: 'BoltSemiBold'),),
                  SizedBox(height: 20.0,),
                  Container(
                    decoration: BoxDecoration(
                        color: kForthColor,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(color: kMainColor,
                              blurRadius: 1.0,
                              offset: Offset(0.1,0.1),
                              spreadRadius: 1.0
                          )
                        ]
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: kMainColor,),
                        SizedBox(width: 10.0,),
                        Text('Search Drop Off',),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  Row(
                    children: [
                      Icon(Icons.home, color: kMainColor, size: 35,),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add Home',),
                          SizedBox(height: 4.0,),
                          Text('Your Living Address', style: TextStyle(color: kMainColor ,fontSize: 12.0, fontFamily: 'Muli', fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  drawDivider(),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [
                      Icon(Icons.work, color: kMainColor,size: 35,),
                      SizedBox(width: 12.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add Work',),
                          SizedBox(height: 4.0,),
                          Text('Your Office Address', style: TextStyle(color: kMainColor ,fontSize: 12.0, fontFamily: 'Muli', fontWeight: FontWeight.w300),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
      ),
    );
  }
}
